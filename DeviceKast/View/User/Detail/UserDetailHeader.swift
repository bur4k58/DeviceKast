//
//  UserDetailHeader.swift
//  DeviceKast
//
//  Created by Burak Ocbe on 06/03/2023.
//

import SwiftUI

struct UserDetailHeader: View {
    @ObservedObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var showDelete = false
    let user: UserModal

    var body: some View {
        ZStack {
            Color("RoyalBlue")
                .ignoresSafeArea()
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .imageScale(.large)
                })
                
                Spacer()
                
                Text("\(user.firstName) \(user.lastName)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                
                Button(action: {
                    self.showDelete = true
                }) {
                    Image(systemName: "trash")
                        .imageScale(.large)
                        .foregroundColor(.white)
                }.sheet(isPresented: $showDelete) {
                    // Show the delete when the user taps the icon
                    DeleteUser(user: user, userViewModel: userViewModel)
                }
            }
            .padding()
        }
    }
}

struct UserDetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailHeader(userViewModel: UserViewModel(), user: UserModal(email: "Test", firstName: "Burak", lastName: "Ocbe", imageUrl: "https://s3-eu-west-1.amazonaws.com/bamboohr-app-eu-west-1-production/images/40310/photos/40600-2-4.jpg", lastActiveAt: Date(), team: "Team 7", rentedDeviceCount: 2))
    }
}
