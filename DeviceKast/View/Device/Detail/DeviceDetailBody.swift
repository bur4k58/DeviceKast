import SwiftUI

struct DeviceDetailBody: View {
    let device: Device
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack{
                VStack (alignment: .leading){
                    Text(device.label)
                        .foregroundColor(Color("LightGrey"))
                        .bold()
                    if device.os == "ios" {
                        Image(systemName: "apple.logo")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    } else if device.os == "android" {
                        Image("android")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                    } else{
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
                .frame(height: 60) // Set the height to match the second VStack
                
                Spacer()
                
                VStack (alignment: .leading){
                    Text("Besturingssyteem: ")
                        .foregroundColor(Color("LightGrey"))
                    
                    Spacer()

                    Text("\(device.os)")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.bottom)
                }
                .frame(height: 60) // Set the height to match the second VStack

            }
            VStack (alignment: .leading){
                Text("Laats uitgeleend: ")
                    .foregroundColor(Color("LightGrey"))
                Text("\(device.timeSinceLastRentedText) dagen geleden")
                    .foregroundColor(.white)
                    .bold()
            }
            
            VStack (alignment: .leading){
                Text("Momenteel uitgeleend door: ")
                    .foregroundColor(Color("LightGrey"))
                
                Text("\(device.rentedByName ?? "Niemand")")
                    .foregroundColor(.white)
                    .bold()
            }
            
            VStack (alignment: .leading){
                Text("Serialnr: ")
                    .foregroundColor(Color("LightGrey"))
                Text("\(device.serialNr)")
                    .foregroundColor(.white)
                    .bold()
            }
            
            VStack (alignment: .leading){
                Text("Imei: ")
                    .foregroundColor(Color("LightGrey"))
                Text("\(device.imei)")
                    .foregroundColor(.white)
                    .bold()
            }
            
            VStack (alignment: .leading){
                Text("Testinium: ")
                    .foregroundColor(Color("LightGrey"))
                if device.testinium {
                    Text("X")
                        .foregroundColor(.white)
                        .bold()
                } else {
                    Text("/")
                        .foregroundColor(.white)
                        .bold()
                }
            }
            
            VStack (alignment: .leading){
                Text("Aantal keer uitgeleend: ")
                    .foregroundColor(Color("LightGrey"))
                Text("\(device.rentedCount)")
                    .foregroundColor(.white)
                    .bold()
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .padding(.leading)
        .frame(maxWidth: .infinity)
    }
}

struct DeviceDetailBody_Previews: PreviewProvider {
    static var previews: some View {
        DeviceDetailBody(device: Device(id: "test", deviceImgUrl: "https://i.ebayimg.com/images/g/FBoAAOSwHMJYOKQn/s-l300.jpg", deviceType: "test", imei: "test", label: "ICAPPSDEV_89", manufacturer: "test", model: "iPhone 12 Pro", os: "ios", rentedByName: "Burak ocbe", rentedCount: 3, serialNr: "test", testinium: true))
    }
}
