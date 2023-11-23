import Foundation
import Combine
import Firebase

class UserViewModel: ObservableObject, Identifiable {
    @Published var list = [UserModal]()
    
    //Get reference  to the database
    let db = Firestore.firestore()
    
    var sorted: [UserModal] {
        get {
            list.sorted { $0.firstName < $1.firstName }
        }
        set {
            list = newValue
        }
    }
    
    init(){
        self.getDataUsers()
    }
    
    func getDataUsers() {
        //Read the document
        db.collection("users").addSnapshotListener { snapshot, error in
            //Check error
            if error == nil {
                
                if let snapshot = snapshot {
                    
                    //Get all the document
                    self.list = snapshot.documents.map { d in
                        
                        //Calculate the date difference
                        let lastActiveDate = (d["last_active_at"] as? Timestamp)?.dateValue() ?? Date()
                        let timeSinceLastActive = -lastActiveDate.timeIntervalSinceNow
                        
                        //Create a UserModal
                        return UserModal(id: d.documentID ,
                                         email: d["email"] as? String ?? "",
                                         firstName: d["first_name"] as? String ?? "",
                                         lastName: d["last_name"] as? String ?? "",
                                         imageUrl: d["image_url"] as? String ?? "",
                                         lastActiveAt: lastActiveDate,
                                         team: d["team"] as? String ?? "",
                                         rentedDeviceCount: d["rented_device_count"] as? Int ?? 0,
                                         timeSinceLastActive: timeSinceLastActive
                        )
                    }
                }
            }
            else{
                print("Error getting users: \(String(describing: error?.localizedDescription))")
                return
            }
        }
    }
    
    func addDataUser(_ user: UserModal) {
        
        db.collection("users").document().setData([
            "email" : user.email,
            "first_name": user.firstName,
            "last_name": user.lastName,
            "image_url": user.imageUrl,
            "team": user.team,
            "rented_device_count": user.rentedDeviceCount,
            "last_active_date": FieldValue.serverTimestamp()
        ]) { error in
            
            if error == nil {
                self.getDataUsers()
            } else {
                fatalError("Unable to add user: \(String(describing: error)).")
            }
        }
    }
    
    func checkIfUserExists(email: String, completion: @escaping (Bool) -> Void) {
        db.collection("users").whereField("email", isEqualTo: email)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting user: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                if let snapshot = snapshot, !snapshot.isEmpty {
                    completion(true)
                } else {
                    completion(false)
                }
            }
    }
    
    func deleteUser(user: UserModal) {
        
        //Specify the document to delete with id
        db.collection("users").document(user.id!).delete { error in
            
            if error == nil {
                // If the delete was successful, remove the user from the list
                if let index = self.list.firstIndex(where: { $0.id == user.id }) {
                    DispatchQueue.main.async {
                        self.list.remove(at: index)
                    }
                }
            }
        }
    }
}
