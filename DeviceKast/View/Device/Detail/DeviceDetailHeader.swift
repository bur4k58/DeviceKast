import SwiftUI

struct DeviceDetailHeader: View {
    @ObservedObject var deviceViewModel: DeviceViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var showDelete = false
    let device: Device

    var body: some View {
        ZStack {
            Color("RoyalBlue")
                .ignoresSafeArea()
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .imageScale(.large)
                })
                
                Spacer()
                
                Text("\(device.model)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                
                Button(action: {
                    self.showDelete = true
                }) {
                    Image(systemName: "trash")
                        .imageScale(.large)
                        .foregroundColor(.white)
                }.sheet(isPresented: $showDelete) {
                    // Show the delete when the user taps the icon
                    DeleteDevice(device: device, deviceViewModel: deviceViewModel)
                }
            }
            .padding()
        }
    }
}


struct DeviceDetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        DeviceDetailHeader(deviceViewModel: DeviceViewModel(), device: Device(id: "test", deviceImgUrl: "https://zdnet4.cbsistatic.com/hub/i/r/2018/06/13/7c0990a5-7a1d-4a1f-a25e-45b4dbf4bec4/thumbnail/770x578/066926a8d7108ab8168b550fb39c1702/oneplus-6header.jpg", deviceType: "test", imei: "test", label: "ICAPPSDEV_89", manufacturer: "test", model: "iPhone 12 Pro", os: "test", rentedByName: "nil", serialNr: "test", testinium: true))
    }
}
