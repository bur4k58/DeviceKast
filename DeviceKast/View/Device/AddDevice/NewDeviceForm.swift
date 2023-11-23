import SwiftUI

struct NewDeviceForm: View {
    @State var deviceImgUrl: String = ""
    @State var deviceType: String = "Phone"
    @State var imei: String = ""
    @State var label: String = ""
    @State var manufacturer: String = ""
    @State var model: String = ""
    @State var os: String = "iOS"
    @State var serialNr: String = ""
    @State var testinium = false
    
    let types = ["Phone", "Watch", "Others"]
    let deviceOs = ["iOS", "Android", "Others"]
    
    @ObservedObject var deviceViewModel: DeviceViewModel
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
                
                Text("Toestel toevoegen")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("RoyalBlue"))
            }
            .padding([.top, .bottom, .trailing])
            
            Group {
                TextField("Model", text: $model)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .shadow(radius: 3)
                
                TextField("Fabrikant", text: $manufacturer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .shadow(radius: 3)
                
                TextField("Serienummer", text: $serialNr)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .shadow(radius: 3)
                
                TextField("Label", text: $label)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .shadow(radius: 3)
                
                TextField("Imei", text: $imei)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .shadow(radius: 3)
                
                TextField("Afbeelding url", text: $deviceImgUrl)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .shadow(radius: 3)
                
                HStack {
                    Text("Toestel type")
                    
                    Spacer()
                    
                    Picker(selection: $deviceType, label: Text("Toestel Type")) {
                        ForEach(types, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                HStack {
                    Text("Besturingssyteem")
                    
                    Spacer()
                    
                    Picker(selection: $os, label: Text("Besturingssyteem")) {
                        ForEach(deviceOs, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Toggle(isOn: $testinium) {
                    Text("Testinium")
                }
            }
            
            Spacer()
                        
            Button(action: {
                addDevice()
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
    
    private func addDevice() {
        // 1. Check if all the required fields are filled
        if deviceImgUrl.isEmpty || imei.isEmpty || label.isEmpty || manufacturer.isEmpty || model.isEmpty || serialNr.isEmpty {
            
            alertMessage = "Alle velden zijn verplicht."
            showAlert.toggle()
            return
        }
        
        // 2. Check if the label already exists in the Firestore collection
        deviceViewModel.checkIfDeviceExists(label: label) { exists in
            if exists {
                // Show an alert to notify the user that the email already exists in the database
                alertMessage = "Toestel bestaat al."
                showAlert.toggle()
            } else {
                let device = Device(deviceImgUrl: deviceImgUrl, deviceType: deviceType.lowercased(), imei: imei, label: label, manufacturer: manufacturer, model: model, os: os.lowercased(), serialNr: serialNr, testinium: testinium)
                deviceViewModel.addDataDevice(device)
                self.presentationMode.wrappedValue.dismiss()
                print("Closed")
            }
        }
    }
}

struct NewDeviceForm_Previews: PreviewProvider {
    static var previews: some View {
        NewDeviceForm(deviceViewModel: DeviceViewModel())
    }
}
