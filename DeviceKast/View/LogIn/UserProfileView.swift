import SwiftUI

struct UserProfileView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    @State var presentingConfirmationDialog = false
    
    private func signOut() {
        viewModel.signOut()
    }
    
    var body: some View {
        Form {
            Section("Email") {
                Text(viewModel.displayName)
            }
            Section("Naam") {
                Text(viewModel.displayFullName)
            }
            Section {
                Button(role: .cancel, action: signOut) {
                    HStack {
                        Spacer()
                        Text("Uitloggen")
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Profiel")
        .navigationBarTitleDisplayMode(.inline)
    }
}
