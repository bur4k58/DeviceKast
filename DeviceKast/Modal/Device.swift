import Foundation
import Combine
import Firebase

struct Device: Identifiable{
    var id: String?
    var deviceImgUrl: String
    var deviceType: String
    var imei: String
    var label: String
    var lastRentedAt: Date?
    var lastRentedBy: DocumentReference?
    var manufacturer: String
    var model: String
    var os: String
    var rentedBy: DocumentReference?
    var rentedByName: String?
    var rentedCount: Int = 0
    var serialNr: String
    var testinium: Bool = false
    
    var timeSinceLastRented: TimeInterval?
    
    var timeSinceLastRentedText: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.day]
        return formatter.string(from: timeSinceLastRented ?? 0) ?? ""
    }
    
    static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs.id == rhs.id // or any other property that makes two UserModal objects equal
    }
}
