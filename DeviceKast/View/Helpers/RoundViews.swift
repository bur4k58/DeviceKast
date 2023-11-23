import SwiftUI

struct RoundedImageOpenForm: View {
    @State var isAnimating = false
    
    var body: some View {
        Image(systemName: "plus.circle.fill")
            .resizable()
            .frame(width: 60, height: 60)
            .foregroundColor(Color("Malibu"))
            .background(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color("Malibu"), lineWidth: 4)
                    .scaleEffect(isAnimating ? 1.5 : 1)
                    .opacity(isAnimating ? 0 : 1)
                    .animation(
                        Animation.easeOut(duration: 3)
                            .repeatForever(autoreverses: false)
                    )
            )
            .onAppear {
                isAnimating = true
            }
    }
}

struct RoundViews_Previews: PreviewProvider {
    static var previews: some View {
        RoundedImageOpenForm()
    }
}
