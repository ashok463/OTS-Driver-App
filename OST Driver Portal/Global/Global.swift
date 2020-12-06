import Foundation
import UIKit

class Global {
    
    private init() {}
    class var shared : Global {
        
        struct Static {
            static let instance : Global = Global()
        }
        return Static.instance
    }
    
    var isLoggedIn: Bool = false
    var fcmToken = kBlankString
    var expenseViewModel:ExpenseViewModel!
    var user: UserLoginViewModel? = UserLoginViewModel()
  }

