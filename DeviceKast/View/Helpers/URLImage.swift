import SwiftUI
import Foundation

struct URLImage: View {
    let url: String
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        VStack {
            // Check if the image has been loaded, and show the image if it has
            if let uiImage = imageLoader.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay {
                        Circle().stroke(Color("LightGrey"), lineWidth: 4)
                    }
                    .shadow(radius: 7)
                    .frame(width: 75, height: 85)
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

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: "https://s3-eu-west-1.amazonaws.com/bamboohr-app-eu-west-1-production/images/40310/photos/40600-2-4.jpg")
    }
}
