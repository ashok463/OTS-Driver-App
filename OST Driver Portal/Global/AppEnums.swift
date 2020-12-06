import Foundation
import UIKit

enum UserStatus:String {
    case Online = "online"
    case Offline = "offline"
}

enum PrefferedLanguage: String{
    case English = "English"
    case Arabic = "Arabic"
    
}

enum LoginType: String {
    case Custom = "custom"
    case Facebook = "fb"
    case Google = "gmail"
    case None = ""
}

struct ColorType {
    static let blue = UIColor(hexFromString: "BB0F20")
    static let textColor = UIColor(hexFromString: "555555")
    static let primaryColor = UIColor(hexFromString: "49CA12")
    static let reddishColor = UIColor(hexFromString: "F74D54")
}
enum NotificationType:String {
    case newBidReceived = "newBidReceived"
    case Default = "default"
    case bidCancel = "bidCancel"
    case bidStart = "bidStart"
    case bidUpdate = "bidUpdate"
    case bidComplete = "bidComplete"
}
