import SwiftUI

struct DeviceRow: View {
    let device: Device
    let index: Int
    
    var body: some View {
        HStack {
            Text("\(index):")

            Text(device.model)
                .font(.callout)
            
            Spacer()
            
            Text("\(device.rentedCount) keer uitgeleend")
                .font(.callout)
        }
        .padding(.horizontal)
    }
}

struct DeviceRow_Previews: PreviewProvider {
    static var previews: some View {
        DeviceRow(device: Device(id: "test", deviceImgUrl: "https://i.ebayimg.com/images/g/FBoAAOSwHMJYOKQn/s-l300.jpg", deviceType: "test", imei: "test", label: "ICAPPSDEV_89", manufacturer: "test", model: "iPhone 12 Pro", os: "test", rentedByName: "Burak Ocbe", rentedCount: 3, serialNr: "test", testinium: false), index: 1)
    }
}
