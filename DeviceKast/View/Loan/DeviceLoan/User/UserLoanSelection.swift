//import SwiftUI
//
//struct UserLoanSelection: View {
//    var userList: [UserModal]
//    let onSelectUser: (UserModal) -> Void
//
//    @State var selectedUser: UserModal? = nil
//    @State var selectedDevice: Device?
//
//    @State var showSecureChoise = false
//    @Binding var showCongratsScreen : Bool
//
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        VStack (spacing: 0){
//            List(userList) { user in
//                UserLoanView(user: user, selectedUser: $selectedUser)
//                    .onTapGesture {
//                        selectedUser = user
//                        onSelectUser(user)
//                    }
//            }
//            .listStyle(.plain)
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarItems(
//                trailing:
//                    HStack{
//                        Button(action: {
//                            presentationMode.wrappedValue.dismiss()
//                        }, label: {
//                            Image(systemName: "arrow.left")
//                                .foregroundColor(.white)
//                                .imageScale(.large)
//                        })
//
//                        Spacer()
//
//                        Text("Maak een keuze uit lijst")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                            .foregroundColor(.white)
//
//                        Spacer()
//                    }
//                    .padding([.leading, .bottom, .trailing])
//                    .frame(width:UIScreen.main.bounds.width)
//            )
//            .toolbarBackground(Color("RoyalBlue"), for: .navigationBar)
//            .background(Color("RoyalBlue"))
//
//            Button(action: {
//                showSecureChoise = true
//            }) {
//                Text("BEVESTIGEN")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.center)
//            }
//            .sheet(isPresented: $showSecureChoise) {
//                LoanSecureChoise(device: selectedDevice!, user: selectedUser!, deviceViewModel: DeviceViewModel(), showCongratsScreen: $showCongratsScreen)
//            }
//            .frame(width:UIScreen.main.bounds.width, height: 70)
//            .background(Color("RoyalBlue"))
//            .disabled(selectedUser == nil)
//            .opacity(selectedUser != nil ? 1: 0.5)
//        }
//        .padding(.bottom, 1.0)
//    }
//}
