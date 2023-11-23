import SwiftUI

struct FilterUser: View {
    @Binding var filterByRentedDeviceCount: Bool // use binding to update the filter toggle
    
    // This environment variable is used to dismiss the view when the "SLUITEN" button is tapped
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Filter gebruikers")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding()
                .padding(.top, 20.0)
            
            // This toggle is used to update the filterByRentedDeviceCount binding
            Toggle(isOn: $filterByRentedDeviceCount) {
                Text("Alleen gebruikers met uitgeleende toestellen")
            }
            .padding()
            
            Spacer()
            
            // This button is used to dismiss the view when tapped
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("SLUITEN")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top)
            }
            .frame(width: 400, height: 70)
            .background(Color("RoyalBlue"))
        }
    }
}

//struct FilterUser_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterUser()
//    }
//}
