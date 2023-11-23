import SwiftUI

struct UserDetailBody: View {
    let user: UserModal

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack (alignment: .leading){
                Text("Email: ")
                    .foregroundColor(Color("LightGrey"))
                Text(user.email)
                    .foregroundColor(.white)
                    .bold()
            }
            VStack (alignment: .leading){
                Text("Team: ")
                    .foregroundColor(Color("LightGrey"))
                Text(user.team)
                    .foregroundColor(.white)
                    .bold()
            }
            VStack (alignment: .leading){
                Text("Laats actief op: ")
                    .foregroundColor(Color("LightGrey"))
                Text("\(user.timeSinceLastActiveText) geleden")
                    .foregroundColor(.white)
                    .bold()
            }
            VStack (alignment: .leading){
                Text("Aantal toestellen in gebruik: ")
                    .foregroundColor(Color("LightGrey"))
                Text("\(user.rentedDeviceCount)")
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

struct UserDetailBody_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserModal(email: "Test", firstName: "Burak", lastName: "Ocbe", imageUrl: "https://s3-eu-west-1.amazonaws.com/bamboohr-app-eu-west-1-production/images/40310/photos/40600-2-4.jpg", lastActiveAt: Date(), team: "Team 7", rentedDeviceCount: 2)
        
        UserDetailBody(user: user)
    }
}
