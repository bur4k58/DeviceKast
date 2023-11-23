import SwiftUI

struct DeviceReturnHome: View {
    var deviceList: [Device]
    
    @State var selectedDevice: Device? = nil
    @State var showCongratsScreen = false
    
    var body: some View {
        VStack {
            if showCongratsScreen {
                CongratsReturn(device: selectedDevice!)
                    .animation(.easeInOut)
            } else {
                DeviceReturnSelection(
                    deviceList: deviceList,
                    onSelectDevice: { device in
                        selectedDevice = device
                    },
                    showCongratsScreen: $showCongratsScreen)
            }
        }
    }
}
