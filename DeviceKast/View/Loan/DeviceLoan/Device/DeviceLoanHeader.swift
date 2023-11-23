import SwiftUI

struct DeviceLoanHeader: View {
    @Binding var filterByRentediOS : Bool
    @Binding var filterByRentedAndroid : Bool
    @Binding var filterByRentedOthers : Bool
    @Binding var showFilter : Bool
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .imageScale(.large)
            })
            
            Spacer()
            
            Text("Maak een keuze uit lijst")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
            
            Button(action: {
                self.showFilter = true
            }) {
                Image(systemName: "slider.horizontal.3")
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .padding(.trailing)
            }.fullScreenCover(isPresented: $showFilter, content: {
                // Show the filter when the user taps the icon
                DeviceLoanFilter(
                    filterByRentediOS: $filterByRentediOS,
                    filterByRentedAndroid: $filterByRentedAndroid,
                    filterByRentedOthers: $filterByRentedOthers
                )
            })
        }
    }
}
