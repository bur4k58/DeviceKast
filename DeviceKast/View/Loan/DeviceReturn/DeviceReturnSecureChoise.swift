import SwiftUI

struct DeviceReturnSecureChoise: View {
    var device: Device
    let authViewModel = AuthenticationViewModel()

    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @ObservedObject var deviceViewModel: DeviceViewModel
    @Binding var showCongratsScreen : Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Bent u zeker dat u \(device.model) \(device.label) wilt inleveren?")
                .font(.title2)
                .padding()
                .padding(.bottom, 200.0)
            
            HStack {
                Button(action: {
                    returnDevice(device: device) { error in
                        if let error = error {
                            fatalError("Unable to return device: \(error.localizedDescription)")
                        } else {
                            showCongratsScreen = true
                        }
                    }
                }, label: {
                    Text("JA")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                })
                .frame(width: 150.0, height: 60.0)
                .background(Color("LightGrey"))
                .padding()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("NEE")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                })
                .frame(width: 150.0, height: 60.0)
                .background(Color("LightGrey"))
            }
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        })
    }
    
    private func returnDevice(device: Device, completion: @escaping (Error?) -> Void) {
        authViewModel.fetchUserFromFirebase { user in
            if let user = user {
                deviceViewModel.returnDevice(device) { error in
                    if let error = error {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                }
            } else {
                // User not found in Firebase
                let errorMessage = "Gebruiker niet gevonden maak een gebruiker aan met login gegevens"
                print(errorMessage)
                alertMessage = errorMessage
                showAlert = true
            }
        }
    }
}
