import SwiftUI

struct DeviceReturnSelection: View {
    var deviceList: [Device]
    let onSelectDevice: (Device) -> Void
    
    @State var selectedDevice: Device? = nil
    @State var showSecureChoise = false
    @Binding var showCongratsScreen : Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack (spacing: 0){
            List(deviceList) { device in
                DeviceReturnView(device: device, selectedDevice: $selectedDevice)
                    .onTapGesture {
                        selectedDevice = device
                        onSelectDevice(device)
                    }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing:
                    HStack{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.white)
                                .imageScale(.large)
                        })
                        
                        Spacer()
                        
                        Text("Maak een keuze uit lijst")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding([.leading, .bottom, .trailing])
                    .frame(width:UIScreen.main.bounds.width)
            )
            .toolbarBackground(Color("RoyalBlue"), for: .navigationBar)
            .padding(.top, 1.0)
            .background(Color("RoyalBlue"))

                        
            Button(action: {
                self.showSecureChoise = true
            }) {
                Text("BEVESTIGEN")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }.sheet(isPresented: $showSecureChoise) {
                DeviceReturnSecureChoise(device: selectedDevice!, deviceViewModel: DeviceViewModel(), showCongratsScreen: $showCongratsScreen)
            }
            .frame(width:UIScreen.main.bounds.width, height: 70)
            .background(Color("RoyalBlue"))
            .disabled(selectedDevice == nil)
            .opacity(selectedDevice != nil ? 1: 0.5)
            .padding(.bottom, 1.0)
        }
        .padding(.bottom, 1.0)
    }
}
