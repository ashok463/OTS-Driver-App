import Foundation
import UIKit

typealias ParamsAny = [String:Any]
typealias ParamsString = [String:String]

struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X_All = (UIDevice.current.userInterfaceIdiom == .phone && (ScreenSize.SCREEN_MAX_LENGTH == 812 || ScreenSize.SCREEN_MAX_LENGTH == 896))
    static let IS_IPHONE_X = (UIDevice.current.userInterfaceIdiom == .phone && (ScreenSize.SCREEN_MAX_LENGTH == 812))
    static let IS_IPHONE_X_MAX = (UIDevice.current.userInterfaceIdiom == .phone && (ScreenSize.SCREEN_MAX_LENGTH == 896))
}

var TOP_BAR_HEIGHT:CGFloat = 54
var BOTTOM_BAR_HEIGHT:CGFloat = 65
var PROFILE_VIEW_HEIGHT:CGFloat = 270
let ANIMATION_TIME = 0.6




let PRINT_API_RESPONSE = false

let KEEP_LOGIN = "keepLogin"
let USER = "user"
let ALERT_TITLE_APP_NAME = "OTS DRIVER CONNECT"
let kAppVersion = "1.2"
//let kApplicationId = "2374627836482734" // dummy value for now
let kApplicationId = "1504605928"
//"1504605928"

struct EndPoints {
    static let BASE_URL                     = "https://secure.onlinetruckingsolution.com/api/driver/"
    //"https://staging1129.onlinetruckingsolution.com/api/driver/"
    
    static let userRegisterUrl              = "register"
    static let loginUrl                     = "auth/login"
    static let load_details                 = "load_details"
    static let settlement                   = "settlement"
    static let checkversion                 = "checkversion"
    static let checktoken                   = "checktoken"
    static let changestatus                 = "changestatus"
    static let uploadbol                    = "uploadbol"
    static let bol_delivery                 = "bol_delivery"
    static let loadExpences                 = "loadexpense"
    static let deleteExpense                = "deleteexpense"
    static let addexpense                   = "addexpense"
    static let getstates                    = "getstates"
    static let getcities                    = "getcities"
    static let saveexpense                  = "saveexpense"
    static let addvendor                    = "addvendor"
    static let editexpense                  = "editexpense"
    static let updateexpense                = "updateexpense"
    static let versionID                    = "/\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "")"
}

//Default values for data types
let kBlankString = ""

let kInt0 = 0
let kIntDefault = -1

let kDouble0 = 0.0
let kDoubleDefault = -1.0




