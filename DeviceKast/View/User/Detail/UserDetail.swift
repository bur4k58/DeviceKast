import SwiftUI

struct UserDetail: View {
    var userViewModel = UserViewModel()
    let user: UserModal
    
    var body: some View {
        VStack {
            ZStack{
                Color("RoyalBlue")
                    .ignoresSafeArea()
                VStack {
                    ScrollView {
                        UserDetailHeader(userViewModel: userViewModel, user: user)
                        UserImage(image: user.imageUrl)
                        UserDetailBody(user: user)
                    }
                }
            }
        }
        .navigationBarHidden(true) // hide the navigation bar of the nested NavigationView
        .padding(.bottom, 1.0)
    }
}

struct UserDetail_Previews: PreviewProvider {
    static var previews: some View {
        UserDetail(userViewModel: UserViewModel(), user: UserModal(email: "Test", firstName: "Burak", lastName: "Ocbe", imageUrl: "https://s3-eu-west-1.amazonaws.com/bamboohr-app-eu-west-1-production/images/40310/photos/40600-2-4.jpg", lastActiveAt: Date(), team: "Team 7", rentedDeviceCount: 2))
    }
}
