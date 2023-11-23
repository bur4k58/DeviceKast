import SwiftUI

struct DeleteDevice: View {
    var device: Device
    @ObservedObject var deviceViewModel: DeviceViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Bent u zeker dat u \(device.model) \(device.label) wilt verwijderen?")
                .font(.title2)
                .padding()
                .padding(.bottom, 200.0)
                        
            HStack {
                Button(action: {
                    print("Yes")
                    deleteDevice()
                    self.presentationMode.wrappedValue.dismiss()
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
                .background(Color("ButtonNo"))

            }
        }
    }
    
    private func deleteDevice() {
        deviceViewModel.deleteDevice(device: device)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct DeleteDevice_Previews: PreviewProvider {
    static var previews: some View {
        DeleteDevice(device: Device(id: "test", deviceImgUrl: "https://i.ebayimg.com/images/g/FBoAAOSwHMJYOKQn/s-l300.jpg", deviceType: "test", imei: "test", label: "ICAPPSDEV_89", manufacturer: "test", model: "iPhone 12 Pro", os: "test", rentedByName: "Burak Ocbe", rentedCount: 3, serialNr: "test", testinium: false), deviceViewModel: DeviceViewModel())
    }
}
