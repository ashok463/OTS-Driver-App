//
//  SceneDelegate.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 17/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Siren
import Firebase
import FirebaseCore
import FirebaseInstanceID

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        IQKeyboardManager.shared.enable = true
        //self.setupInitialController()
        guard let sceneView = (scene as? UIWindowScene) else { return }
        getFcmToken(windowScene: sceneView)
    }
    
    fileprivate func getFcmToken(windowScene: UIWindowScene) {
        InstanceID.instanceID().instanceID { (instanceResult, error) in
            if let error = error {
                print(error.localizedDescription)
            }else if let result = instanceResult {
                print("FCM token = \(result.token)")
                Global.shared.fcmToken = result.token
                //                self.setupInitialController()
                if UserDefaultsManager.shared.isUserLoggedIn{
                    
                    let storyboard = UIStoryboard.init(name: "Registration", bundle: nil)
                    if let kYDrawerController = storyboard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController{
                        let navController = UINavigationController.init(rootViewController:
                            kYDrawerController)
                        navController.isNavigationBarHidden = true
                        let newWindow = UIWindow.init(windowScene: windowScene)
                        newWindow.rootViewController = navController
                        newWindow.makeKeyAndVisible()
                        self.window = newWindow
                    }else{
                        print("ds")
                    }
                }else{
                    print("gfhghg")
                }
            }
        }
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
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
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
}

