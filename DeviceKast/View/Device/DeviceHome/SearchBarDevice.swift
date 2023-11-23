
import SwiftUI

struct SearchBarDevice: View {
    @Binding var searchText : String
    @Binding var isSearching : Bool
    @Binding var showForm : Bool
    @Binding var showFilter : Bool
    @Binding var filterByRentedDevice: Bool
    @Binding var filterByAvailable: Bool
    @Binding var filterByBetaDevice: Bool
    
    var body: some View {
        HStack {
            // show the search bar if the user is searching
            if isSearching {
                TextField("Zoeken...", text: $searchText)
                    .padding(.horizontal, 30.0)
                    .padding(.vertical, 6)
                    .cornerRadius(8)
                    .font(.system(size: 14))
                    .background(.white)
                    .cornerRadius(20)
                Button(action: {
                    // Close the search bar when the user taps the icon
                    isSearching = false
                    searchText = ""
                }) {
                    Image(systemName: "multiply.circle")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .padding(.trailing, 30.0)
                }
            } else {
                // show the title and search and filter icons if the user is not searching
                Text("Toestellen")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    // Open the search bar when the user taps the icon
                    isSearching = true
                }) {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .padding(.trailing, 30.0)
                }
                
                Button(action: {
                    self.showFilter = true
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .padding(.trailing)
                }.fullScreenCover(isPresented: $showFilter, content: {
                    // Show the filter when the user taps the icon
                    FilterDevice(
                        filterByRentedDevice: $filterByRentedDevice,
                        filterByAvailable: $filterByAvailable,
                        filterByBetaDevice: $filterByBetaDevice) // pass the filters toggle binding
                })
            }
        }
    }
}
