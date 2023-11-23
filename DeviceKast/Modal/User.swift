import Foundation

struct UserModal: Identifiable, Codable {
    var id: String?
    var badgeId: String?
    var email: String
    var firstName: String
    var lastName: String
    var imageUrl: String
    var lastActiveAt: Date
    var team: String
    var rentedDeviceCount: Int = 0
    var timeSinceLastActive: TimeInterval?
    
    var timeSinceLastActiveText: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.day]
        return formatter.string(from: timeSinceLastActive ?? 0) ?? ""
    }
    
    static func == (lhs: UserModal, rhs: UserModal) -> Bool {
        return lhs.id == rhs.id // or any other property that makes two UserModal objects equal
    }
}
