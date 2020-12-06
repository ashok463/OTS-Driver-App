//
//  UserDefaultsManager.swift
//  OrderAte
//
//  Created by Gulfam Khan on 12/09/2019.
//  Copyright © 2019 Rapidzz. All rights reserved.
//

import Foundation

 struct UserDefaultsKeys {
    static let isUserLoggedIn = "isUserLoggedIn"
    static let loggedInUserInfo = "loggedInUserInfo"
}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let manager = UserDefaults.standard
    
    private init() {}
    
    var currentLocale:String {
        set {
            manager.set(newValue, forKey:"locale")
            manager.synchronize()
        }
        get {
            return manager.string(forKey: "locale") ?? "ar"
        }
    }
    
    var isUserLoggedIn:Bool {
        set {
            manager.set(newValue, forKey:UserDefaultsKeys.isUserLoggedIn)
            manager.synchronize()
        }
        get {
            return manager.bool(forKey: UserDefaultsKeys.isUserLoggedIn)
        }
    }
    
    var loggedInUserInfo:UserLoginViewModel? {
        set {
            let data = try! NSKeyedArchiver.archivedData(withRootObject: newValue!, requiringSecureCoding: false)
            manager.set(data, forKey: UserDefaultsKeys.loggedInUserInfo)
            manager.synchronize()
        }
        get {
            if let data = manager.data(forKey: UserDefaultsKeys.loggedInUserInfo) {
                
                do {
                    let userInfo = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! UserLoginViewModel
                    return userInfo
                } catch {
                  print("An error occurred: \(error)")
                    return nil
                }
//                let userInfo = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! UserLoginViewModel
                
            }else {
                return nil
            }
            
        }
    }
    
    func clearUserData() {
        manager.removeObject(forKey: UserDefaultsKeys.isUserLoggedIn)
        manager.removeObject(forKey: UserDefaultsKeys.loggedInUserInfo)
        manager.synchronize()
    }
}
