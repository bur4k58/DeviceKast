import SwiftUI

struct UserLoanView: View {
    var user: UserModal
    @Binding var selectedUser: UserModal?

    var body: some View {
        HStack {
            URLImage(url: user.imageUrl)
                .padding(.leading)
            
            VStack {
                HStack {
                    Text("\(user.firstName) \(user.lastName)")
                        .font(.custom("Naam", size: 16))
                    
                    Spacer()
                }
                .padding(.bottom, 5.0)
                
                HStack {
                    Text(user.team)
                        .multilineTextAlignment(.leading)
                        .font(.custom("Naam", size: 16))

                    Spacer()
                    Text("Gebruikt \(user.rentedDeviceCount) toestellen")
                        .foregroundColor(Color("MediumGrey"))
                        .multilineTextAlignment(.trailing)
                        .font(.custom("Naam", size: 14))
                        .keyboardType(.decimalPad)
                }
            }
            .padding(.leading)
            
            Spacer()
        }
        .frame(width:UIScreen.main.bounds.width)
        .padding(.trailing)
        .background(selectedUser.map { $0 == user } ?? false ? Color("LightGrey") : Color.white)
        .opacity(selectedUser.map { $0 == user } ?? false ? 0.5 : 1.0)
    }
}
