import SwiftUI

struct DeviceHomePage: View {
    var deviceList: [Device]
    
    @State private var searchText = "" // create a state variable to store the search text
    @State private var isSearching = false // create a state variable to store whether the user is searching or not
    @State var showForm = false // create a state variable to show/hide the new user form
    
    @State var showFilter = false // create a state variable to show/hide the filter
    @State private var filterByRentedDevice = false
    @State var filterByAvailable = false
    @State var filterByBetaDevice = false

    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(filterDeviceList()) { device in
                        NavigationLink {
                            DeviceDetail(device: device)
                        } label: {
                            DeviceView(device: device)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    trailing:
                        SearchBarDevice(
                            searchText: $searchText,
                            isSearching: $isSearching,
                            showForm: $showForm,
                            showFilter: $showFilter,
                            filterByRentedDevice: $filterByRentedDevice,
                            filterByAvailable: $filterByAvailable,
                            filterByBetaDevice: $filterByBetaDevice
                        )
                        .padding([.leading, .bottom, .trailing])
                    .frame(width:UIScreen.main.bounds.width)
                )
                .toolbarBackground(Color("RoyalBlue"), for: .navigationBar)
                .background(Color("RoyalBlue"))
            }
            
            Button(action: {
                self.showForm = true
            }) {
                RoundedImageOpenForm()
            }.fullScreenCover(isPresented: $showForm, content: {
                // show the new device form
                NewDeviceForm(deviceViewModel: DeviceViewModel())
            })
            .position(x: UIScreen.main.bounds.width - 50, y: UIScreen.main.bounds.height - 200)
        }
        .padding(.bottom, 1.0)
    }
    
    // create a closure to filter the user list based on the filter toggle
    private func filterDeviceList() -> [Device] {
        var filteredList = deviceList
        
        // Filter by rented device
        if filterByRentedDevice {
            filteredList = filteredList.filter { $0.rentedBy != nil }
        }
        
        // Filter by beta device
        if filterByBetaDevice {
            filteredList = filteredList.filter { $0.testinium == true }
        }
        
        // Filter by available device
        if filterByAvailable {
            filteredList = filteredList.filter { $0.rentedByName == nil }
        }
        
        // Filter by search text
        if !searchText.isEmpty {
            filteredList = filteredList.filter { device in
                device.model.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return filteredList
    }
}
//
//struct DeviceHomePage_Previews: PreviewProvider {
//    static var previews: some View {
//        DeviceHomePage()
//    }
//}
