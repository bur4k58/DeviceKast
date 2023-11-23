import SwiftUI

struct LoanHome: View {
//    var userList: [UserModal]
    var deviceList: [Device]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Maak een keuze")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("RoyalBlue"))
                    .padding(40.0)
                
                NavigationLink(destination: DeviceLoanHome(
//                    userList: userList,
                    deviceList: deviceList.filter({ $0.rentedBy == nil }))) {
                    Text("Toestel lenen")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 350, height: 70)
                .background(Color("RoyalBlue"))
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .padding(50.0)
                
                NavigationLink(destination: DeviceReturnHome(
                    deviceList: deviceList.filter({ $0.rentedBy != nil }))) {
                    Text("Toestel inleveren")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("RoyalBlue"))
                        .multilineTextAlignment(.center)
                }
                .frame(width: 350, height: 70)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color("RoyalBlue"), lineWidth: 1)
                )
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct LoanHome_Previews: PreviewProvider {
    static var previews: some View {
        LoanHome(deviceList: DeviceViewModel().sorted)
    }
}
