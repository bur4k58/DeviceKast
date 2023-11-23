import SwiftUI

struct DeviceReturnView: View {
    var device: Device
    @Binding var selectedDevice: Device?
    
    var body: some View {
        HStack {
            URLImageDevice(url: device.deviceImgUrl)
                .padding(.leading)
            
            VStack {
                HStack {
                    Text("\(device.model)")
                    
                    Spacer()
                }
                .padding(.bottom, 5.0)
                
                HStack {
                    Text("\(device.label)")
                        .foregroundColor(Color("LightGrey"))
                    
                    Spacer()
                    
                    Text("\((device.rentedByName) ?? "")")
                        .foregroundColor(.black)
                }
            }
            .padding(.leading)
        }
        .frame(width:UIScreen.main.bounds.width)
        .padding(.trailing)
        .background(selectedDevice.map { $0 == device } ?? false ? Color("LightGrey") : Color.white)
        .opacity(selectedDevice.map { $0 == device } ?? false ? 0.5 : 1.0)
    }
}
