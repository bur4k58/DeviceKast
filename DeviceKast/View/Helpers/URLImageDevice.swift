//
//  URLImageDevice.swift
//  DeviceKast
//
//  Created by Burak Ocbe on 09/03/2023.
//

import SwiftUI

struct URLImageDevice: View {
    let url: String
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        VStack {
            // Check if the image has been loaded, and show the image if it has
            if let uiImage = imageLoader.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 7)
                    .frame(width: 75, height: 75)
            } else {
                // If the image hasn't been loaded yet, show a placeholder image
                Image("noimage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay {
                        Circle().stroke(Color("LightGrey"), lineWidth: 4)
                    }
                    .shadow(radius: 7)
                    .frame(width: 75, height: 85)
            }
            // Use a task to download the image asynchronously
        }.task {
            await downloadImage()
        }
    }
    
    private func downloadImage() async{
        do {
            try await imageLoader.fetchImage(URL(string: url))
        } catch {
            print(error)
        }
    }
}

struct URLImageDevice_Previews: PreviewProvider {
    static var previews: some View {
        URLImageDevice(url: "https://i.ebayimg.com/images/g/FBoAAOSwHMJYOKQn/s-l300.jpg")
    }
}
