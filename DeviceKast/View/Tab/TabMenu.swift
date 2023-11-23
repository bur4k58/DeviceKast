import SwiftUI

struct TabMenu: View {
    @State private var selection: Tab = .users
    var userList: [UserModal]
    @StateObject var deviceViewModel = DeviceViewModel()
    
    enum Tab {
        case users
        case devices
        case stats
        case loans
        case profile
    }
    
    var body: some View {
        TabView(selection: $selection) {
            UserHomePage(userList: userList)
                .tabItem {
                    Label("Gebruikers", systemImage: "person.2.fill")
                }
                .tag(Tab.users)
            
            DeviceHomePage(deviceList: deviceViewModel.sorted)
                .tabItem {
                    Label("Toestellen", systemImage: "ipad.and.iphone")
                }
                .tag(Tab.devices)
            
            StatsHome(userList: userList, deviceList: deviceViewModel.sorted)
                .tabItem {
                    Label("Statistieken", systemImage: "chart.bar.xaxis")
                }
                .tag(Tab.stats)
            
            LoanHome(deviceList: deviceViewModel.sorted)
                .tabItem {
                    Label("Leningen", systemImage: "arrow.triangle.2.circlepath.circle")
                }
                .tag(Tab.loans)
                .animation(.easeInOut)
            
            UserProfileView(viewModel: AuthenticationViewModel())
                .tabItem {
                    Label("Profiel", systemImage: "person.fill")
                }
                .tag(Tab.profile)
                .animation(.easeInOut)
        }
        .accentColor(Color("RoyalBlue"))
        .background(Color("MediumGrey"))
    }
}
