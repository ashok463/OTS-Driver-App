//
//  UserLoginViewModel.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 26/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserLoginViewModel:NSObject, NSCoding {
    
    var id: Int
    var company_id: String
    var username: String
    var driver_name: String
    var device_token: String
    var device_platform: String
    var profile_image: String
    
    override init(){
        self.id = 0
        self.company_id = ""
        self.username = ""
        self.driver_name = ""
        self.device_token = ""
        self.device_platform = ""
        self.profile_image = ""
    }
    
    convenience init(user: JSON) {
        self.init()
        self.id = user["id"].intValue
        self.company_id = user["company_id"].stringValue
        self.username = user["username"].stringValue
        self.driver_name = user["driver_name"].stringValue
        self.device_token = user["device_token"].stringValue
        self.device_platform = user["device_platform"].stringValue
        self.profile_image = user["profile_image"].stringValue
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.company_id, forKey: "company_id")
        aCoder.encode(self.username, forKey: "username")
        aCoder.encode(self.driver_name, forKey: "driver_name")
        aCoder.encode(self.device_token, forKey: "device_token")
        aCoder.encode(self.device_platform, forKey: "device_platform")
        aCoder.encode(self.profile_image, forKey: "profile_image")
    }
    
    required convenience init(coder aDecoder: NSCoder){
        self.init()
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.company_id = aDecoder.decodeObject(forKey: "company_id") as! String
        self.username = aDecoder.decodeObject(forKey: "username") as! String
        self.driver_name = aDecoder.decodeObject(forKey: "driver_name") as! String
        self.device_token = aDecoder.decodeObject(forKey: "device_token") as! String
        self.device_platform = aDecoder.decodeObject(forKey: "device_platform") as! String
        self.profile_image = aDecoder.decodeObject(forKey: "profile_image") as! String
    }
    
}
