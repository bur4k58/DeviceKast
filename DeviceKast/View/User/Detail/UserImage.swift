//
//  CircleImage.swift
//  DeviceKast
//
//  Created by Burak Ocbe on 28/02/2023.
//

import SwiftUI

struct UserImage: View {
    var image: String
    
    var body: some View {
        AsyncImage(url: URL(string: image)) { phase in
            switch phase {
            case .empty:
                // Placeholder image while the image is being loaded
                ProgressView()
            case .success(let image):
                // The loaded image
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 10)
            case .failure(_):
                // An error occurred while loading the image
                Image("noimage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 10)
            }
        }
    }
}

struct UserImage_Previews: PreviewProvider {
    static var previews: some View {
        UserImage(image: "https://s3-eu-west-1.amazonaws.com/bamboohr-app-eu-west-1-production/images/40310/photos/40600-2-4.jpg")
    }
}
