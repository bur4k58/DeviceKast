import SwiftUI

struct DeviceLoanHome: View {
    
//    var userList: [UserModal]
    var deviceList: [Device]
    @State var selectedDevice: Device?
//    @State var selectedUser: UserModal?
    @State var showCongratsScreen = false
    
    var body: some View {
        VStack {
            if showCongratsScreen {
               CongratsLoan(device: selectedDevice!)
               .animation(.easeInOut)
            } else {
                DeviceLoanSelection(deviceList: deviceList, onSelectDevice: { device in
                    selectedDevice = device
                }, showCongratsScreen: $showCongratsScreen)
            }
            
//            if selectedDevice == nil {
//                DeviceLoanSelection(deviceList: deviceList, onSelectDevice: { device in
//                    selectedDevice = device
//                })
//            } else if showCongratsScreen {
//                CongratsLoan(device: selectedDevice!, user: selectedUser!)
//                    .animation(.easeInOut)
//            } else {
//                UserLoanSelection(userList: userList, onSelectUser: { user in
//                    selectedUser = user
//                }, selectedDevice: selectedDevice, showCongratsScreen: $showCongratsScreen)
//            }
        }
    }
}
