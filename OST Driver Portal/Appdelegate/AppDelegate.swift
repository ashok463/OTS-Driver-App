//
//  AppDelegate.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 17/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit
import DropDown
import Firebase
import FirebaseMessaging
import FirebaseCore
import FirebaseInstanceID
import CoreLocation
import IQKeyboardManagerSwift
import Siren

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        updateAppForcefully()
        DropDown.startListeningToKeyboard()
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        registerForRemoteNotifications(application)
        getFcmToken()
        
        // Override point for customization after application launch.
        return true
    }
    
    func setupInitialController() {
        if window == nil {
            window = UIWindow()
        }
        let storyboard = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        if UserDefaultsManager.shared.isUserLoggedIn {
            Global.shared.user = UserDefaultsManager.shared.loggedInUserInfo
        }
        window?.rootViewController = controller
        
        window?.makeKeyAndVisible()
    }
    
    func updateAppForcefully() {
        let siren = Siren.shared
        siren.rulesManager = RulesManager(globalRules: .critical,
                                          showAlertAfterCurrentVersionHasBeenReleasedForDays: 0)
        
        siren.wail { results in
            switch results {
            case .success(let updateResults):
                print("AlertAction ", updateResults.alertAction)
                print("Localization ", updateResults.localization)
                print("Model ", updateResults.model)
                print("UpdateType ", updateResults.updateType)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func getFcmToken() {
        InstanceID.instanceID().instanceID { (instanceResult, error) in
            if let error = error {
                print(error.localizedDescription)
            }else if let result = instanceResult {
                print("FCM token = \(result.token)")
                Global.shared.fcmToken = result.token
                //                self.setupInitialController()
                
                if UserDefaultsManager.shared.isUserLoggedIn{
                    let storyboard = UIStoryboard.init(name: "Registration", bundle: nil)
                    let kYDrawerController = (storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController)!
                    let navController = UINavigationController.init(rootViewController:
                        kYDrawerController)
                    Global.shared.user = UserDefaultsManager.shared.loggedInUserInfo
                    navController.isNavigationBarHidden = true
                    self.window = UIWindow()
                    self.window?.makeKeyAndVisible()
                    self.window?.rootViewController = navController
                }
            }
        }
    }
    
    
    fileprivate func registerForRemoteNotifications(_ application:UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        
        application.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase token \(fcmToken)")
        Global.shared.fcmToken = fcmToken
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let notificationData = notification.request.content.userInfo
        print(notificationData)
        completionHandler([.alert,.sound,.badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let notificationData = response.notification.request.content.userInfo
        print(notificationData)
        completionHandler()
    }
}

