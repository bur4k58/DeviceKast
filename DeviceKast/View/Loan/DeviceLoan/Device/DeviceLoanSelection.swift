import SwiftUI

struct DeviceLoanSelection: View {
    var deviceList: [Device]
    let onSelectDevice: (Device) -> Void
    @State private var selectedDevice: Device? = nil
    
    @State private var showFilter = false
    @State private var filterByRentediOS = false
    @State private var filterByRentedAndroid = false
    @State private var filterByRentedOthers = false
    
    @State private var showSecureChoise = false
    @Binding var showCongratsScreen: Bool
    
    var body: some View {
        VStack {
            List(filterDeviceList()) { device in
                DeviceLoanView(device: device, selectedDevice: $selectedDevice)
                    .onTapGesture {
                        selectedDevice = device
                        onSelectDevice(device)
                    }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing:
                    DeviceLoanHeader(filterByRentediOS: $filterByRentediOS, filterByRentedAndroid: $filterByRentedAndroid, filterByRentedOthers: $filterByRentedOthers, showFilter: $showFilter)
                    .padding([.leading, .bottom, .trailing])
                    .frame(width: UIScreen.main.bounds.width)
            )
            .toolbarBackground(Color("RoyalBlue"), for: .navigationBar)
            .background(Color("RoyalBlue"))
            
            Button(action: {
                showSecureChoise = true
            }) {
                Text("BEVESTIGEN")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .sheet(isPresented: $showSecureChoise) {
                LoanSecureChoise(device: selectedDevice!, deviceViewModel: DeviceViewModel(), showCongratsScreen: $showCongratsScreen)
            }
            .frame(width: UIScreen.main.bounds.width, height: 70)
            .background(Color("RoyalBlue"))
            .disabled(selectedDevice == nil)
            .opacity(selectedDevice != nil ? 1: 0.5)
            
        }
        .padding(.bottom, 1.0)
    }
    
    private func filterDeviceList() -> [Device] {
        var filteredList = deviceList
        
        if filterByRentediOS {
            filteredList = filteredList.filter { $0.os == "ios" }
        }
        
        if filterByRentedAndroid {
            filteredList = filteredList.filter { $0.os == "android" }
        }
        
        if filterByRentedOthers {
            filteredList = filteredList.filter { $0.os == "other" }
        }
        
        return filteredList
    }
}
