import SwiftUI

struct Header: View {
    var title: String
    
    var body: some View {
        ZStack{
            Color("RoyalBlue")
                .ignoresSafeArea()
            VStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
    }
    
    struct Header_Previews: PreviewProvider {
        static var previews: some View {
            Header(title: "Statistieken")
        }
    }
}
