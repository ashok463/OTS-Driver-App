//
//  SplashViewController.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 03/03/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit
import CoreLocation

class SplashViewController: BaseViewController {
    
    private var locationManager = CLLocationManager()
    
    //MARK:- Override methhods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SplashViewController.networkStatusChanged(_:)), name: Notification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupInitialController()
//        setupLocationManager()
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let status = userInfo["Status"] as! String
            print(status)
            
            let status1 = Reach().connectionStatus()
            switch status1 {
            case .unknown, .offline:
                print("Not connected")
            case .online(.wwan):
                print("Connected via WWAN")
            case .online(.wiFi):
                print("Connected via WiFi")
            }
        }
        
    }
    //MARK:- Custom methods
    fileprivate func setupInitialController() {
        
        let storyboard = UIStoryboard(name: StoryboardNames.Registration, bundle: nil)
        var controller: UIViewController!
        if UserDefaultsManager.shared.isUserLoggedIn {
            Global.shared.user = UserDefaultsManager.shared.loggedInUserInfo
            controller = storyboard.instantiateViewController(withIdentifier: ControllerIdentifier.MainContainerViewController) as! MainContainerViewController
        }else {
            controller = storyboard.instantiateInitialViewController()
        }
        self.navigationController?.setViewControllers([controller], animated: true)
        
//        if UserDefaultsManager.shared.isUserLoggedIn {
//            Global.shared.user = UserDefaultsManager.shared.loggedInUserInfo
//        if #available(iOS 13.0, *) {
//            guard let kYDrawerController = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else {return}
//            self.navigationController?.pushViewController(kYDrawerController, animated: true)
//        } else {
//            // Fallback on earlier versions
//            guard let kYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {return}
//            self.navigationController?.pushViewController(kYDrawerController, animated: true)
//        }
        }
    }
    
    fileprivate func setupLocationManager() {
//        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            locationManager.requestWhenInUseAuthorization()
//            apiCallCheckVersion()
//        }else if CLLocationManager.authorizationStatus() == .notDetermined {
//            locationManager.requestWhenInUseAuthorization()
//        }else {
//            self.showAlertView(message: PopupMessages.locationPermissionRequired, title: LocalStrings.Alert, doneButtonTitle: LocalStrings.OK, doneButtonCompletion: { (_) in
//                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
//            }, cancelButtonTitle: LocalStrings.Cancel)
//        }
//    }

}

extension SplashViewController {
    fileprivate func apiCallCheckVersion(){
        self.startActivityWithMessage()
        GCD.async(.Background) {
            let param = ["version_id": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""]
            RegisterationService.shared().checkVersion(params: param) { (message, success, checkVersion) in
                GCD.async(.Main) {
                    self.stopActivity()
                    if success{
                        if checkVersion!.iosV == kAppVersion {
                            GCD.async(.Main, delay: 1) {
                                self.setupInitialController()
                            }
                        }else {
                            self.showAlertView(message: "Please update your application to latest version to proceed", title: "Important", doneButtonTitle: "Update",doneButtonCompletion:  { (_) in
                                guard let url = URL(string: "itms-apps://itunes.apple.com/app/id\(kApplicationId)") else {
                                        return
                                }
                                if UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }
                            }, cancelButtonTitle: "Cancel")
                        }
                    }else{
                        GCD.async(.Main, delay: 1) {
                            self.setupInitialController()
                        }
                    }
                }
                
            }
        }
    }
}
