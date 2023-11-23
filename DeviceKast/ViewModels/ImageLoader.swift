import Foundation
import UIKit

// Define a custom error type for network errors
enum NetworkError: Error {
    case badRequest
    case unsupportedImage
    case badUrl
}

@MainActor
class ImageLoader: ObservableObject {
    // Declare a @Published property that holds the loaded UIImage
    @Published var uiImage: UIImage?
    
    // Declare a static cache that stores previously loaded images
    private static let cache = NSCache<NSString, UIImage>()
    
    // Declare a function that loads an image from the specified URL asynchronously
    func fetchImage(_ url: URL?) async throws {
        
        guard let url = url else {
            throw NetworkError.badUrl
        }
        
        let request = URLRequest(url: url)
        
        // Check if the image is already cached, use the cached image if available
        if let cachedImage = Self.cache.object(forKey: url.absoluteString as NSString) {
            uiImage = cachedImage
        } else {
            // Fetch the image data and the server's response asynchronously
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Check if the server responded with an HTTP 200 OK status code
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw NetworkError.badRequest
            }
            
            // Create a UIImage from the fetched data
            guard let image = UIImage(data: data) else {
                throw NetworkError.unsupportedImage
            }
            
            // Cache the fetched image for future use
            Self.cache.object(forKey: url.absoluteString as NSString)
            uiImage = image
        }
    }
}
