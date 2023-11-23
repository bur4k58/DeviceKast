import SwiftUI

struct DeviceDetail: View {
    var deviceViewModel = DeviceViewModel()
    let device: Device
    
    var body: some View {
        VStack {
            ZStack{
                Color("RoyalBlue")
                    .ignoresSafeArea()
                VStack {
                    ScrollView {
                        DeviceDetailHeader(deviceViewModel: deviceViewModel, device: device)
                        UserImage(image: device.deviceImgUrl)
                        DeviceDetailBody(device: device)
                    }
                }
            }
        }
        .navigationBarHidden(true) // hide the navigation bar of the nested NavigationView
        .padding(.bottom, 1.0)
    }
}

struct DeviceDetail_Previews: PreviewProvider {
    static var previews: some View {
        DeviceDetail(deviceViewModel: DeviceViewModel(), device: Device(id: "test", deviceImgUrl: "https://i.ebayimg.com/images/g/FBoAAOSwHMJYOKQn/s-l300.jpg", deviceType: "test", imei: "test", label: "ICAPPSDEV_89", manufacturer: "test", model: "iPhone 12 Pro", os: "test", rentedByName: "Burak Ocbe", rentedCount: 3, serialNr: "test", testinium: false))
    }
}
