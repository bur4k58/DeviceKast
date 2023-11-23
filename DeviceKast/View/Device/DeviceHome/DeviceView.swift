import SwiftUI

struct DeviceView: View {
    var device: Device
    
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
            }
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
        }
    }
}

struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceView(device: Device(id: "test", deviceImgUrl: "https://zdnet4.cbsistatic.com/hub/i/r/2018/06/13/7c0990a5-7a1d-4a1f-a25e-45b4dbf4bec4/thumbnail/770x578/066926a8d7108ab8168b550fb39c1702/oneplus-6header.jpg", deviceType: "test", imei: "test", label: "ICAPPSDEV_89", manufacturer: "test", model: "iPhone 12 Pro", os: "test", rentedByName: "nil", serialNr: "test", testinium: true))
    }
}
