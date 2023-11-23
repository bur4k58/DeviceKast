import SwiftUI

extension HomePage where Unauthenticated == EmptyView {
    init() {
        self.unauthenticated = nil
    }
}

struct HomePage<Unauthenticated>: View where Unauthenticated: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    var unauthenticated: Unauthenticated?
    
    public init(unauthenticated: Unauthenticated?) {
        self.unauthenticated = unauthenticated
    }
    
    public init(@ViewBuilder unauthenticated: @escaping () -> Unauthenticated) {
        self.unauthenticated = unauthenticated()
    }
    
    var body: some View {
        switch viewModel.authenticationState {
        case .unauthenticated, .authenticating:
            LogIn(viewModel: AuthenticationViewModel())
        case .authenticated:
            Splashscreen()
        }
    }
}
