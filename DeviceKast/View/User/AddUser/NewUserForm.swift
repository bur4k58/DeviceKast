import SwiftUI

struct NewUserForm: View {
    @State var email: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var imageUrl: String = ""
    @State var team: String = ""
    @ObservedObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 30.0) {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color("RoyalBlue"))
                        .imageScale(.large)
                })
                
                Spacer()
                
                Text("Gebruiker toevoegen")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("RoyalBlue"))
            }
            .padding([.top, .bottom, .trailing])
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .shadow(radius: 3)
            
            TextField("Voornaam", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .shadow(radius: 3)
            
            TextField("Achternaam", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .shadow(radius: 3)
            
            TextField("Team", text: $team)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .shadow(radius: 3)
            
            TextField("Afbeelding url", text: $imageUrl)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .shadow(radius: 3)
            
            Spacer()

            Button(action: {
                addUser()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("TOEVOEGEN")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top)
            }
            .frame(width: 500, height: 70)
            .background(Color("RoyalBlue"))

        }
        .padding(EdgeInsets(top: 20, leading: 40, bottom: 0, trailing: 40))
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func addUser() {
        // 1. Check if all the required fields are filled
        if email.isEmpty || firstName.isEmpty || lastName.isEmpty || imageUrl.isEmpty || team.isEmpty {
            alertMessage = "Alle velden zijn verplicht."
            showAlert.toggle()
            return
        }

        // 2. Validate the email format
        guard isValidEmail(email) else {
            // Show an alert to notify the user to enter a valid email address
            alertMessage = "Email is niet correct."
            showAlert.toggle()
            return
        }

        // 3. Check if the email already exists in the Firestore collection
        userViewModel.checkIfUserExists(email: email) { exists in
            if exists {
                // Show an alert to notify the user that the email already exists in the database
                alertMessage = "Email is al in gebruik."
                showAlert.toggle()
            } else {
                let user = UserModal(email: email.lowercased(), firstName: firstName, lastName: lastName, imageUrl: imageUrl, lastActiveAt: Date(), team: team)
                userViewModel.addDataUser(user)
                self.presentationMode.wrappedValue.dismiss()
                print("Closed")
            }
        }
    }

    // Helper function to validate the email format and control if it ends with icapps.com
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email) {
            return email.hasSuffix("@icapps.com")
        }
        return false
    }
}

struct NewUserForm_Previews: PreviewProvider {
    static var previews: some View {
        NewUserForm(userViewModel: UserViewModel())
    }
}
