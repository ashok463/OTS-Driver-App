//
//  ElementViewModel.swift
//  Zon Bau
//
//  Created by Gulfam Khan on 05/09/2019.
//  Copyright © 2019 AcclivousByte. All rights reserved.
//


import Foundation
import SwiftyJSON

class UserViewModel: NSObject, NSCoding {
    
    //MARK:- data members
    var userId:Int
    var username:String
    var email:String
    var avatar:String
    var loginType:String
    var fcmToken:String
    var rating:Double
    var userStatus:UserStatus
    
    //MARK:- Init methods
    override init() {
        userId = kInt0
        username = kBlankString
        email = kBlankString
        avatar = kBlankString
        loginType = LoginType.Custom.rawValue
        fcmToken = kBlankString
        rating = kDouble0
        userStatus = .Offline
    }
    
    convenience init(jsonDict:JSON) {
        self.init()
        userId = jsonDict["id"].intValue
        username = jsonDict["user_name"].stringValue
        email = jsonDict["email"].stringValue
        avatar = jsonDict["avatar"].stringValue
        loginType = jsonDict["login_type"].stringValue
        fcmToken = jsonDict["fcm_token"].stringValue
        rating = jsonDict["rating"].doubleValue
        userStatus = UserStatus(rawValue: jsonDict["user_status"].stringValue) ?? .Offline
    }
    
    convenience init(userId:Int, fullName: String, image: String, email: String, loginType: String, fcmToken: String, rating:Double, userStatus:UserStatus) {
        
        self.init()
        self.userId = userId
        self.username = fullName
        self.avatar = image
        self.email = email
        self.loginType = loginType
        self.fcmToken = fcmToken
        self.rating = rating
        self.userStatus = userStatus
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userId, forKey: "id")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(avatar, forKey: "avatar")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(loginType, forKey: "loginType")
        aCoder.encode(fcmToken, forKey: "fcmToken")
        aCoder.encode(rating, forKey: "rating")
        aCoder.encode(userStatus.rawValue, forKey: "userStatus")
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let userId = aDecoder.decodeInteger(forKey: "id")
        let fullName = aDecoder.decodeObject(forKey: "username") as? String ?? kBlankString
        let avatar = aDecoder.decodeObject(forKey: "avatar") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let loginType = aDecoder.decodeObject(forKey: "loginType") as! String
        let fcmToken = aDecoder.decodeObject(forKey: "fcmToken") as! String
        let rating = aDecoder.decodeDouble(forKey: "rating")
        let statusRawValue = aDecoder.decodeObject(forKey: "userStatus") as! String
        let userStatus = UserStatus(rawValue: statusRawValue)
        self.init(userId:userId, fullName: fullName, image: avatar, email: email, loginType: loginType, fcmToken: fcmToken, rating: rating, userStatus: userStatus ?? .Offline)
    }
}
