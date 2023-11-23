import SwiftUI

struct UserRow: View {
    let user: UserModal
    
    var body: some View {
        HStack {
            Text("\(user.firstName) \(user.lastName)")
                .font(.callout)
            
            Spacer()
            
            Text("\(user.rentedDeviceCount) toestellen")
                .font(.callout)
        }
        .padding(.horizontal)
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRow(user: UserModal(email: "Test", firstName: "Burak", lastName: "Ocbe", imageUrl: "https://s3-eu-west-1.amazonaws.com/bamboohr-app-eu-west-1-production/images/40310/photos/40600-2-4.jpg", lastActiveAt: Date(), team: "Team 7", rentedDeviceCount: 2))
    }
}
