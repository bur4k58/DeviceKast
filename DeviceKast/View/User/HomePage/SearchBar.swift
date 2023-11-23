//
//  SearchBar.swift
//  DeviceKast
//
//  Created by Burak Ocbe on 09/03/2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText : String // create a state variable to store the search text
    @Binding var isSearching : Bool // create a state variable to store whether the user is searching or not
    @Binding var showFilter : Bool // create a state variable to show/hide the filter
    @Binding var filterByRentedDeviceCount: Bool // create a state variable to track the filter toggle
    
    var body: some View {
        HStack {
            // show the search bar if the user is searching
            if isSearching {
                TextField("Zoeken...", text: $searchText)
                    .padding(.horizontal, 30.0)
                    .padding(.vertical, 6)
                    .cornerRadius(8)
                    .font(.system(size: 14))
                    .background(.white)
                    .cornerRadius(20)
                Button(action: {
                    // Close the search bar when the user taps the icon
                    isSearching = false
                    searchText = ""
                }) {
                    Image(systemName: "multiply.circle")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .padding(.trailing, 30.0)
                }
            } else {
                // show the title and search and filter icons if the user is not searching
                Text("Gebruikers")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    // Open the search bar when the user taps the icon
                    isSearching = true
                }) {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .padding(.trailing, 30.0)
                }
                
                Button(action: {
                    self.showFilter = true
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .padding(.trailing)
                }.fullScreenCover(isPresented: $showFilter, content: {
                    // Show the filter when the user taps the icon
                    FilterUser(filterByRentedDeviceCount: $filterByRentedDeviceCount) // pass the filter toggle binding
                })
            }
        }
    }
}
