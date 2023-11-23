import SwiftUI
import GoogleSignIn

struct UserHomePage: View {
    @StateObject var userViewModel = UserViewModel() // create a UserViewModel as a state object
    var userList: [UserModal] // create an array of UserModal objects to store the user data
    @State private var searchText = "" // create a state variable to store the search text
    @State private var isSearching = false // create a state variable to store whether the user is searching or not
    @State var showForm = false // create a state variable to show/hide the new user form
    @State var showFilter = false // create a state variable to show/hide the filter
    @State private var filterByRentedDeviceCount = false // create a state variable to track the filter toggle
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(filterUserList()) { user in
                        NavigationLink {
                            UserDetail(user: user)
                        } label: {
                            UserView(user: user)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    trailing:
                        SearchBar(
                            searchText: $searchText, isSearching: $isSearching,
                            showFilter: $showFilter, filterByRentedDeviceCount: $filterByRentedDeviceCount
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
                NewUserForm(userViewModel: userViewModel)
            })
            .position(x: UIScreen.main.bounds.width - 50, y: UIScreen.main.bounds.height - 200)
        }
        .padding(.bottom, 1.0)
    }
    
    
    // create a closure to filter the user list based on the filter toggle
    private func filterUserList() -> [UserModal] {
        var filteredList = userList
        
        // Filter by rented device count
        if filterByRentedDeviceCount {
            filteredList = filteredList.filter { $0.rentedDeviceCount > 0 }
        }
        
        // Filter by search text
        if !searchText.isEmpty {
            filteredList = filteredList.filter { user in
                user.firstName.localizedCaseInsensitiveContains(searchText) ||
                user.lastName.localizedCaseInsensitiveContains(searchText) ||
                user.team.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return filteredList
    }
}

struct UserHomePage_Previews: PreviewProvider {
    static var previews: some View {
        UserHomePage(userList: UserViewModel().list)
    }
}
