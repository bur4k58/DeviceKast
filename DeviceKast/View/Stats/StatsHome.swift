import SwiftUI

struct StatsHome: View {
    var userList: [UserModal]
    var deviceList: [Device]
    
    var body: some View {
        VStack {
            Header(title: "Statistieken")
                .frame(height: 20)
            
            ScrollView {
                VStack {
                    // Top 10 most rented devices
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Meest geleende toestellen")
                            .font(.headline)
                            .padding()
                        ForEach(Array(deviceList.enumerated().sorted(by: { $0.element.rentedCount > $1.element.rentedCount }).prefix(10)), id: \.offset) { index, device in
                            HStack {
                                Text(device.model)
                                    .font(.callout)
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Text("\(device.rentedCount)")
                                    .font(.callout)
                                    .foregroundColor(.black)
                                
                                BarView(value: CGFloat(device.rentedCount) / CGFloat(deviceList.map { $0.rentedCount }.max() ?? 1))
                                    .frame(width: 150, height: 20)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom)
                    .background(Color("LightGrey"))
                    
                    // Top 10 least rented devices
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Minst geleende toestellen")
                            .font(.headline)
                            .padding()
                        ForEach(Array(deviceList.enumerated().sorted(by: { $0.element.rentedCount < $1.element.rentedCount }).prefix(10)), id: \.offset) { index, device in
                            HStack {
                                Text(device.model)
                                    .font(.callout)
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Text("\(device.rentedCount)")
                                    .font(.callout)
                                    .foregroundColor(.black)
                                
                                BarView(value: CGFloat(device.rentedCount) / CGFloat(deviceList.map { $0.rentedCount }.max() ?? 1))
                                    .frame(width: 150, height: 20)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom)
                    .background(Color("Oddessy"))
                    
                    // Top 10 most active users
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Meest actieve gebruikers")
                            .font(.headline)
                            .padding()
                        ForEach(Array(userList.sorted(by: { $0.rentedDeviceCount > $1.rentedDeviceCount }).prefix(10))) { user in
                            HStack {
                                Text("\(user.firstName) \(user.lastName)")
                                    .font(.callout)
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Text("\(user.rentedDeviceCount)")
                                    .font(.callout)
                                    .foregroundColor(.black)
                                
                                BarView(value: CGFloat(user.rentedDeviceCount) / CGFloat(userList.map { $0.rentedDeviceCount }.max() ?? 1))
                                    .frame(width: 150, height: 20)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom)
                    .background(Color("LightGrey"))
                    
                    // Top 10 most active users
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Minst actieve gebruikers")
                            .font(.headline)
                            .padding()
                        ForEach(Array(userList.sorted(by: { $0.rentedDeviceCount < $1.rentedDeviceCount }).prefix(10))) { user in
                            HStack {
                                Text("\(user.firstName) \(user.lastName)")
                                    .font(.callout)
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Text("\(user.rentedDeviceCount)")
                                    .font(.callout)
                                    .foregroundColor(.black)
                                
                                BarView(value: CGFloat(user.rentedDeviceCount) / CGFloat(userList.map { $0.rentedDeviceCount }.max() ?? 1))
                                    .frame(width: 150, height: 20)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom)
                    .background(Color("Oddessy"))
                }
                .padding()
            }
            .padding(.vertical)
        }
    }
}

struct StatsHome_Previews: PreviewProvider {
    static var previews: some View {
        StatsHome(userList: UserViewModel().sorted, deviceList: DeviceViewModel().sorted)
    }
}
