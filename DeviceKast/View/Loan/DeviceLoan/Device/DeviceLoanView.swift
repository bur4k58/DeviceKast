import SwiftUI

struct DeviceLoanView: View {
    var device: Device
    @Binding var selectedDevice: Device?
    
    var body: some View {
        if device.rentedByName != nil {
            ZStack {
                HStack {
                    URLImageDevice(url: device.deviceImgUrl)
                        .padding(.leading)
                    
                    VStack {
                        HStack {
                            Text("\(device.model)")
                            
                            Spacer()
                            
                            if device.testinium {
                                Text("Beta test")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("RoyalBlue"))
                            }
                        }
                        .padding(.bottom, 5.0)
                        
                        HStack {
                            Text("\(device.label)")
                                .foregroundColor(Color("LightGrey"))
                            
                            Spacer()
                            
                            if device.rentedByName != "" {
                                Text("Uitgeleend")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("RoyalBlue"))
                            }
                        }
                    }
                    .padding(.leading)
                }
                .frame(width:UIScreen.main.bounds.width)
                .padding(.trailing)
                .background(selectedDevice.map { $0 == device } ?? false ? Color("LightGrey") : Color.white)
                .opacity(selectedDevice.map { $0 == device } ?? false ? 0.5 : 1.0)            }
        } else {
            HStack {
                URLImageDevice(url: device.deviceImgUrl)
                    .padding(.leading)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(device.model)")
                        
                        Spacer()
                        
                        if device.testinium {
                            Text("Beta test")
                                .fontWeight(.bold)
                                .foregroundColor(Color("RoyalBlue"))
                        }
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("\(device.label)")
                            .foregroundColor(Color("LightGrey"))
                        Spacer()
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
}
