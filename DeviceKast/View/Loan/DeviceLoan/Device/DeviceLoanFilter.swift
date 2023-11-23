import SwiftUI

struct DeviceLoanFilter: View {
    @Binding var filterByRentediOS : Bool
    @Binding var filterByRentedAndroid : Bool
    @Binding var filterByRentedOthers : Bool
    
    // This environment variable is used to dismiss the view when the "SLUITEN" button is tapped
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Filter Toestellen")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding()
                .padding(.top, 20.0)
            
            Toggle(isOn: $filterByRentediOS) {
                Text("iOS")
            }
            .padding()
            
            Toggle(isOn: $filterByRentedAndroid) {
                Text("Android")
            }
            .padding()
            
            Toggle(isOn: $filterByRentedOthers) {
                Text("Anderen")
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
