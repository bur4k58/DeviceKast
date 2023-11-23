import SwiftUI

struct BarView: View {
    var value: CGFloat
    @State private var animationProgress: CGFloat = 0.0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.white)
                    .shadow(radius: 2, x: 0, y: 2)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                Rectangle()
                    .foregroundColor(Color("RoyalBlue"))
                    .shadow(radius: 2, x: 0, y: 2)
                    .frame(width: geometry.size.width * animationProgress, height: geometry.size.height)
                    .animation(.spring())
                    .onAppear {
                        animationProgress = value
                    }
            }
        }
    }
}
