import Foundation
import Combine
import Firebase

class DeviceViewModel: ObservableObject, Identifiable {
    @Published var list = [Device]()
    
    //Get reference  to the database
    let db = Firestore.firestore()
    
    var sorted: [Device] {
        get {
            list.sorted { $0.model < $1.model}
        }
        set {
            list = newValue
        }
    }
    
    init(){
        getDataDevices()
    }
    
    func getDataDevices() {
        // Create a listener for changes to the devices collection
        db.collection("devices").addSnapshotListener { snapshot, error in
            // Check for errors
            if error == nil {
                // If there's no error, get the documents
                if let snapshot = snapshot {
                    // Map the documents to an array of Device objects
                    self.list = snapshot.documents.map { d in
                        // Get the last rented date and calculate the time since
                        let lastRentedDate = (d["last_rented_at"] as? Timestamp)?.dateValue() ?? Date()
                        let timeSinceLastRented = -lastRentedDate.timeIntervalSinceNow
                        // Create a Device
                        return Device(
                            id: d.documentID,
                            deviceImgUrl: d["device_img_url"] as? String ?? "",
                            deviceType: d["device_type"] as? String ?? "",
                            imei: d["imei"] as? String ?? "",
                            label: d["label"] as? String ?? "",
                            lastRentedAt: lastRentedDate,
                            lastRentedBy: d["last_rented_by"] as? DocumentReference,
                            manufacturer: d["manufacturer"] as? String ?? "",
                            model: d["model"] as? String ?? "",
                            os: d["os"] as? String ?? "",
                            rentedBy: d["rented_by"] as? DocumentReference,
                            rentedByName: d["rented_by_name"] as? String ?? nil,
                            rentedCount: d["rented_count"] as? Int ?? 0,
                            serialNr: d["serial_nr"] as? String ?? "",
                            testinium: d["testinium"] as? Bool ?? false,
                            timeSinceLastRented: timeSinceLastRented)
                    }
                }
            }
            else{
                print("Error getting devices: \(String(describing: error?.localizedDescription))")
                return
            }
        }
    }
    
    func deleteDevice(device: Device) {
        // Specify the document to delete with id
        db.collection("devices").document(device.id!).delete { error in
            if error == nil {
                // If the delete was successful, remove the device from the list
                if let index = self.list.firstIndex(where: { $0.id == device.id }) {
                    DispatchQueue.main.async {
                        self.list.remove(at: index)
                    }
                }
            }
        }
    }
    
    func addDataDevice(_ device: Device) {
        db.collection("devices").document().setData([
            "device_img_url": device.deviceImgUrl,
            "device_type": device.deviceType,
            "imei": device.imei,
            "label": device.label,
            "last_rented_at": nil,
            "last_rented_by": nil,
            "manufacturer": device.manufacturer,
            "model": device.model,
            "os": device.os,
            "rented_by": nil,
            "rented_by_name": nil,
            "rented_count": 0,
            "serial_nr": device.serialNr,
            "testinium": device.testinium
        ]) { error in
            if let error = error {
                fatalError("Unable to add device: \(error.localizedDescription)")
            }
        }
    }
    
    func checkIfDeviceExists(label: String, completion: @escaping (Bool) -> Void) {
        db.collection("device").whereField("label", isEqualTo: label)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting device: \(error.localizedDescription)")
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
    
    func loanDevice(_ device: Device, _ user: UserModal, completion: @escaping (Error?) -> Void) {
        let fullName = user.firstName + " " + user.lastName
        let rentedDeviceCount = user.rentedDeviceCount + 1
        
        // Create a DocumentReference for the user document
        let userRef = db.collection("users").document(user.id!)
        
        db.collection("users").document(user.id!).setData([
            "rented_device_count" : rentedDeviceCount
        ], merge: true) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
        
        db.collection("devices").document(device.id!).setData([
            "last_rented_at": Date(),
            "last_rented_by": userRef, // set the rented_by field as a DocumentReference path
            "rented_by": userRef, // set the rented_by field as a DocumentReference path
            "rented_by_name": fullName
        ], merge: true) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }

    
    func returnDevice(_ device: Device, completion: @escaping (Error?) -> Void) {
        db.collection("devices").document(device.id!).setData([
            "rented_by": nil,
            "rented_by_name": nil
        ], merge: true) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}
