import SwiftUI

struct CongratsLoan: View {
    let device: Device
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color("RoyalBlue")
                .ignoresSafeArea()
            VStack (alignment: .center){
                Image("icapps")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.white)
                    .padding()
                    .padding(.horizontal, 40.0)

                Spacer()
                
                Text("Succes, geleend!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                
                Text("Toestel: \(device.model)")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    Text("Home pagina")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("RoyalBlue"))
                        .multilineTextAlignment(.center)
                }
                .frame(width: 350, height: 70)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .padding(50.0)

                Spacer()
            }
            .padding()
        }
        .padding(.bottom, 1.0)
        .navigationBarHidden(true)
    }
}
