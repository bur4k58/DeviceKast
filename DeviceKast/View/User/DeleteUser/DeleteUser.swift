//
//  DeleteUser.swift
//  DeviceKast
//
//  Created by Burak Ocbe on 08/03/2023.
//

import SwiftUI

struct DeleteUser: View {
    var user: UserModal
    @ObservedObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Bent u zeker dat u \(user.firstName) \(user.lastName) wilt verwijderen?")
                .font(.title2)
                .padding()
                .padding(.bottom, 200.0)
                        
            HStack {
                Button(action: {
                    deleteUser()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("JA")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                })
                .frame(width: 150.0, height: 60.0)
                .background(Color("LightGrey"))
                .padding()
                                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("NEE")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                })
                .frame(width: 150.0, height: 60.0)
                .background(Color("ButtonNo"))

            }
        }
    }
    
    private func deleteUser() {
        userViewModel.deleteUser(user: user)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct DeleteUser_Previews: PreviewProvider {
    static var previews: some View {
        DeleteUser(user: UserModal(email: "test", firstName: "test", lastName: "test", imageUrl: "test", lastActiveAt: Date(), team: "Test"), userViewModel: UserViewModel())
    }
}
