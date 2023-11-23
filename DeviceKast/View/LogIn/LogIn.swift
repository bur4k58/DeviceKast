import SwiftUI

struct LogIn: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var size = 0.7
    @State private var opacity = 0.5
    
    private func signInWithGoogle() {
        Task {
            if await viewModel.signInWithGoogle() == true {
                dismiss()
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color("RoyalBlue")
            
            VStack {
                Image("icapps")
                    .resizable(resizingMode: .stretch)
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(size) // Apply scale effect to the image
                    .animation(.interpolatingSpring(stiffness: 100, damping: 10)) // Add animation with spring effect
                                                
                VStack {
                    Text("U bent niet ingelogd. \nLog in met een icapps account")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .bold()
                    
                    Button(action: signInWithGoogle) {
                        Text("Inloggen met Google")
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .bold()
                            .background(alignment: .leading) {
                                Image("Google")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, alignment: .center)
                            }
                    }
                    .buttonStyle(.bordered)
                }
                .listStyle(.plain)
                .padding()
            }
            .opacity(opacity)
            .onAppear{
                withAnimation(.easeIn(duration: 1.2)) {
                    self.size = 1.0
                    self.opacity = 1.0
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}
