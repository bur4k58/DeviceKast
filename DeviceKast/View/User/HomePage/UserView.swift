import SwiftUI

struct UserView: View {
    var user: UserModal
    
    var body: some View {
        HStack {
            URLImage(url: user.imageUrl)
            
            VStack {
                HStack {
                    Text("\(user.firstName) \(user.lastName)")
                        .font(.custom("Naam", size: 16))
                    
                    Spacer()
                    
                    if user.timeSinceLastActiveText != "0 days" {
                        Text("\(user.timeSinceLastActiveText)")
                            .foregroundColor(Color("MediumGrey"))
                            .multilineTextAlignment(.trailing)
                            .font(.custom("Naam", size: 14))
                    } else {
                        Text("Nooit")
                            .foregroundColor(Color("MediumGrey"))
                            .multilineTextAlignment(.trailing)
                            .font(.custom("Naam", size: 14))
                    }
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
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserModal(email: "Test", firstName: "Burak", lastName: "Ocbe", imageUrl: "https://s3-eu-west-1.amazonaws.com/bamboohr-app-eu-west-1-production/images/40310/photos/40600-2-4.jpg", lastActiveAt: Date(), team: "Team 7", rentedDeviceCount: 2)
        
        UserView(user: user)
    }
}
