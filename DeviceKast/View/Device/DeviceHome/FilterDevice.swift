import SwiftUI

struct FilterDevice: View {
    @Binding var filterByRentedDevice: Bool // use binding to update the filter toggle
    @Binding var filterByAvailable: Bool // use binding to update the filter toggle
    @Binding var filterByBetaDevice: Bool // use binding to update the filter toggle

    
    // This environment variable is used to dismiss the view when the "SLUITEN" button is tapped
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Filter toestellen")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding()
                .padding(.top, 20.0)
            
            // This toggle is used to update the filterByRentedDevice binding
            Toggle(isOn: $filterByRentedDevice) {
                Text("Alleen uitgeleende toestellen")
            }
            .padding()
            
            // This toggle is used to update the filterByRentedDevice binding
            Toggle(isOn: $filterByAvailable) {
                Text("Alleen beschikbare toestellen")
            }
            .padding()
            
            // This toggle is used to update the filterByRentedDevice binding
            Toggle(isOn: $filterByBetaDevice) {
                Text("Alleen beta test toestellen")
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
