
import Foundation
import UIKit

let TERMS_AND_CONDITION = "I agree to the Temrs & Conditions of User Agreement & Privacy Policy"

let FAILED_MESSAGE = "Failed Please Try Again!"
let FAILED = "Failed"
let LOGIN_KEY = "login"
let EMAIL_REGULAR_EXPRESSION = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

let STRING_SUCCESS = ""
let STRING_UNEXPECTED_ERROR = ""
let TIMEOUT_MESSAGE = "Request Time out"
let ERROR_NO_NETWORK = "Connection lost. Please check your internet connection and try again."//"Internet connection is currently unavailable."

struct ServiceMessage {
    static let LocationTitle = "Location Service Off"
    static let LocationMessage = "Turn on Location in Settings > Privacy to allow OTS Driver to determine your Location"
    static let Settings = "Settings"
    static let CameraTitle = "Permission Denied"
    static let CameraMessage = "Turn on Camera in Settings"
}
struct SideMenu {
    static let MENULIST = [["title":"HOME","image":"IconHome"],
                           ["title":"PROFILE","image":"IconUserProfile"],
                           ["title":"CART / ORDER","image":"IconCart"],
                           ["title":"HISTORY","image":"IconHistory"],
                           ["title":"TOOLS","image":"IconTools"],
                           ["title":"LANGUAGES","image":"IconHelp"],
                           ["title":"ABOUT US","image":"IconAboutUs"]]
}

struct TitleName {
    static let Dashboard = "Dashboard"
    static let Dispatch = "Dispatch"
    static let PickupsDelivery = "Pickup's & Delivery"
    static let UploadBol = "Upload BOL"
    static let Expenses = "Expenses"
    static let AddAnExpense = "Add an Expense"
    static let AddaVendor = "Add a Vendor"
    static let editExpense = "Edit Expense Details"
}




struct ControllerIdentifier {

    static let RevealNavigationController = "revealNavigation"
    static let SWRevealViewController = "SWRevealViewController"
    static let BaseNavigationController = "BaseNavigationController"
    static let LanguageSelectionViewController = "LanguageSelectionViewController"
    static let MainContainerViewController = "MainContainerViewController"
    static let MainContainerNavigationController = "MainContainerNavigationController"
    static let SignupViewController = "SignupViewController"
    static let SignInViewController = "SignInViewController"
    static let HomeViewController = "HomeViewController"
    static let HomeBaseNavigationController = "HomeBaseNavigationController"
    static let DispatchViewController = "DispatchViewController"
    static let ExpenseViewController = "ExpenseViewController"
    static let PickupDetailsViewController = "PickupDetailsViewController"
    static let UploadBolViewController = "UploadBolViewController"
    static let ViewDetailsViewController = "ViewDetailsViewController"
    static let AddExpenseViewController = "AddExpenseViewController"
    static let AddVenderViewController = "AddVenderViewController"
    static let SearchVendorViewController = "SearchVendorViewController"
    static let SettlementViewModel = "SettlementViewModel"
    static let LoginViewController = "LoginViewController"
    static let DisplayImageViewController = "DisplayImageViewController"
}

struct APIKeys {
    static let googleApiKey = "AIzaSyBTfypSbx_zNMhWSBXMTA2BJBMQO7_9_T8"
}

struct DictKeys {
    static let id = "id"
    static let userId = "user_id"
    static let userName = "username"
    static let loadId = "load_id"
    static let unitId = "unit_id"
    static let galoons = "galoons"
    static let refGallons = "ref_gallons"
    static let defGallons = "def_gallons"
    static let odometer = "odometer"
    static let _country = "country"
    static let countryShort = "country_short"
    static let state = "state"
    static let stateShort = "state_short"
    static let city = "city"
    static let zipCode = "zipcode"
    static let bol = "bol"
    static let lat = "lat"
    static let lng = "lng"
    static let date = "date"
    static let type = "type"
    static let amount = "amount"
    static let vendorId = "vendor_id"
    static let bolUpload = "bol_upload"
    static let companyId = "company_id"
    static let picture = "picture"
    static let fcmToken = "fcm_token"
    static let password = "password"
    static let description = "description"
    static let device_token = "device_token"
    static let device_platform = "device_platform"
    static let driver_id = "driver_id"
    static let expenseId = "expense_id"
    static let country = "country"
    static let name = "name"
    static let phone = "phone"
    static let street = "street"
    static let deliveryId = "delivery_id"
    static let uploadReceipt = "upload_receipt"
}

struct CellIdentifiers {
    static let MenuItemTableViewCell = "MenuItemTableViewCell"
    static let SideMenuTableViewCell = "SideMenuTableViewCell"
    static let SideMenuExtraTableViewCell = "SideMenuExtraTableViewCell"
    static let RestaurantCategoriesCollectionViewCell = "RestaurantCategoriesCollectionViewCell"
    static let expenseCell = "expenseCell"
    static let pickupDetailCell = "pickupDetailCell"
    static let vendorCell = "vendorCell"
}

struct Assets {
    static let carIcon = "Car icon"
    static let rememberUserDefault = "check_circle_empty"
    static let rememberUserSelected = "check_circle_tick"
}


struct NavigationTitles {
    static let detailController = "detailController"
}

struct StoryboardNames {
    static let Main = "Main"
    static let Registration = "Registration"
    static let Home = "Home"
    static let Detail = "Detail"
    static let Popup = "Popup"
}

struct LocalStrings {
    static let NoDataFound = "No data found"
    static let OK = "OK"
    static let Yes = "Yes"
    static let No = "No"
    static let Alert = "Alert"
    static let Cancel = "Cancel"
    static let Camera = "Camera"
    static let UploadPDF = "Upload PDF"
    static let CaptureImage = "Capture Image"
    static let UploadImage = "Upload Image"
    static let UploadFile = "Upload File"
    static let PhotoLibrary = "Photo Library"
    static let OrderCompleted = "Order Completed"
    static let CancelBid = "CANCEL BID"
    static let AwardBid = "AWARD BID"
    static let OtherBidApproved = "SOME OTHER BID IS APPROVED"
}

struct Placeholders {
    static let BidCancelReason = "State the reason to cancel the bid approval"
}

struct ValidationMessages {
    static let emptyEmail = "Empty Email"
     static let enterValidEmail = "Enter Valid Email"
     static let emptyPassword = "Empty Password"
     static let shortPassword = "Short Password"
     static let reTypePassword = "Retype Passowrd"
     static let nonMatchingPassword = "Non Matching Password"
    static let invalidPhoneNumber = "Invalid Phone Number"
    
    
}
struct PopupMessages {
    static let shortPasswordError = "Password length must be 7 characters or more"
    static let cameraIsNotAvailable = "Camera is not available"
    static let userNameRequired = "Please enter user name"
    static let passwordRequired = "Please enter your password"
    static let shortUsernameError = "Username must be 8 Character"
    static let deleteExpenseMessage = "Are you sure to delete this expense details, it cannot be recovered later"
    static let SomethingWentWrong = "Something went wrong, please check your internet connection or try again later!"
    static let locationPermissionRequired = "Please enable location permission for application to proceed"
}


