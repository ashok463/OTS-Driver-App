    //
    //  LoginViewController.swift
    //  OST Driver Portal
    //
    //  Created by Rizwan Ali on 17/02/2020.
    //  Copyright © 2020 Rapidzz. All rights reserved.
    //
    
    import UIKit
    import Alamofire
    import SwiftyJSON
    
    class LoginViewController: UIViewController {
        
        //    @IBOutlet weak var imgImage: UIImageView!
        //    @IBOutlet weak var txtUsername: UITextField!
        //    @IBOutlet weak var txtPassword: UITextField!
        //    @IBOutlet weak var btnLogin: UIButton!
        
        //IBOutlets
        @IBOutlet weak var logoBackgroundView: UIView!
        @IBOutlet weak var loginBtn: UIButton!
        @IBOutlet weak var emailTextfield: UITextField!
        @IBOutlet weak var passwordTextfield: UITextField!
        @IBOutlet weak var keepMeLoginBtn: UIButton!
        @IBOutlet weak var heightConstraintLogoView: NSLayoutConstraint!
        @IBOutlet weak var widthConstraintLogoView: NSLayoutConstraint!
        @IBOutlet weak var heightConstraintEmailTextField: NSLayoutConstraint!
        @IBOutlet weak var heightConstraintPasswordTextField: NSLayoutConstraint!
        @IBOutlet weak var heightConstraintKeepMeLogin: NSLayoutConstraint!
        @IBOutlet weak var heightConstraintLoginBtn: NSLayoutConstraint!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //self.txtUsername.layer.sublayerTransform = CATransform3DMakeTranslation(30,0,0)
            //        self.txtUsername.leftViewMode = .always
            //        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            //        image.contentMode = .scaleToFill
            //        image.image = UIImage(named: "password")
            //        self.txtUsername.leftView = image
            
            
            // Do any additional setup after loading the view.
            
            ActivityIndicator.shared().show()
            GCD.async(.Background) {
                let param = ["version_id": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""]
                RegisterationService.shared().checkVersion(params: param) { (message, success, checkVersion) in
                    GCD.async(.Main) {
                        ActivityIndicator.shared().hide()
                        if success{
                            print(success)
                            AlertService().showAlert(title: "OTS Driver", message: "Please update your application to latest version to proceed", actionButtonTitle: "OK", completion: {
                                if let url = URL(string:
                                    "https://itunes.apple.com/za/app/ots-driver-connect/id1504605928?mt=8"),
                                    //"itms-apps://itunes.apple.com/app/id\(kApplicationId)"),
                                    UIApplication.shared.canOpenURL(url)
                                {
                                    if #available(iOS 10.0, *) {
                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                    } else {
                                        UIApplication.shared.openURL(url)
                                    }
                                }
                            })
                        }else{
                           print(message)
                        }
                    }
                    
                }
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            if UIDevice.current.userInterfaceIdiom == .pad{
                
                emailTextfield.font = emailTextfield.font?.withSize(28)
                passwordTextfield.font = passwordTextfield.font?.withSize(28)
                heightConstraintLogoView.constant = 400
                widthConstraintLogoView.constant = 400
                heightConstraintEmailTextField.constant = 100
                heightConstraintPasswordTextField.constant = 100
                heightConstraintKeepMeLogin.constant = 0 /* 100  Keep me logged in? */
                heightConstraintLoginBtn.constant = 100
            }
            
            if UIDevice.current.userInterfaceIdiom == .phone{
                
                heightConstraintLogoView.constant = 200
                widthConstraintLogoView.constant = 200
                heightConstraintEmailTextField.constant = 50
                heightConstraintPasswordTextField.constant = 50
                heightConstraintKeepMeLogin.constant = 0 /* 50 Keep me logged in? */
                heightConstraintLoginBtn.constant = 50
            }
            
            loginBtn.cornerRadius(radius: loginBtn.frame.height/2)
            logoBackgroundView.cornerRadius(radius: logoBackgroundView.frame.width/2)
            emailTextfield.setRightIcon(icon: "messageWhite_ic")
            passwordTextfield.setRightIcon(icon: "lockWhite_ic")
            emailTextfield.setUnderLine()
            passwordTextfield.setUnderLine()
            //                keepMeLoginBtn.setImage(UIImage.init(named: "tickmark_ic"), for: .normal)
            //        keepMeLoginBtn.setTitle("  Keep me logged in?", for: .normal)
            //        keepMeLoginBtn.semanticContentAttribute = .forceLeftToRight
        }
        
        @IBAction func actionLogin(_ sender: UIButton) {
            //        if !self.isValidEmail(testStr: txtUsername.text!) {
            //            self.showAlertView(message: "Please enter valid email")
            //        }else if txtPassword.text!.count < 6 {
            //            self.showAlertView(message: "Password is too short")
            //        }else {
            //            apiCall([DictKeys.userName : self.txtUsername.text!,
            //                     DictKeys.password : self.txtPassword.text!,
            //                     DictKeys.device_token : Global.shared.fcmToken,
            //                     DictKeys.device_platform : "ios"])
            //        }
            //121414
            //        apiCall([DictKeys.userName : "prince4dev@gmail.com",
            //        DictKeys.password : "12345678",
            //        DictKeys.device_token : Global.shared.fcmToken,
            //        DictKeys.device_platform : "ios"])
        }
        
        func apiCall(_ params:[String:Any]){
            //        self.startActivityWithMessage()
            ActivityIndicator.shared().show()
            GCD.async(.Background){
                RegisterationService.shared().getUserLogin(params: params) { (message, sucess, userinfo) in
                    GCD.async(.Main) {
                        ActivityIndicator.shared().hide()
                        print(userinfo as Any)
                        //                    self.stopActivity()
                        if sucess{
                            Global.shared.user = userinfo
                            //                        let storyboard = UIStoryboard(name: StoryboardNames.Registration, bundle: nil)
                            //                        let homeVC = storyboard.instantiateViewController(withIdentifier: ControllerIdentifier.MainContainerViewController) as! MainContainerViewController
                            //                        self.navigationController?.pushViewController(homeVC, animated: true)
                            AlertService().showAlert(title: "OTS Driver", message: message, actionButtonTitle: "OK", completion: {
                                if #available(iOS 13.0, *) {
                                    guard let kYDrawerController = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else {return}
                                    self.navigationController?.pushViewController(kYDrawerController, animated: true)
                                } else {
                                    // Fallback on earlier versions
                                    guard let kYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {return}
                                    self.navigationController?.pushViewController(kYDrawerController, animated: true)
                                }
                            })
                            //                         self.showAlertView(message: PopupMessages.loggedInSucessfully)
                        }else{
                            AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {})
                            //                        self.showAlertView(message: message)
                        }
                    }
                }
            }
        }
        
        @IBAction func loginBtn(_ sender: UIButton) {
            
            if Utility.checkTextFieldIsEmpty(textfields: emailTextfield, passwordTextfield){
                let email = emailTextfield.text ?? ""
                if email.isValidEmail == false {
                    AlertService().showAlert(title: "Alert", message: "Please enter valid email", actionButtonTitle: "OK", completion: {})
                    //            self.showAlertView(message: "Please enter valid email")
                }else if passwordTextfield.text!.count < 6 {
                    AlertService().showAlert(title: "Alert", message: "Password is too short", actionButtonTitle: "OK", completion: {})
                    //            self.showAlertView(message: "Password is too short")
                }else {
                    ActivityIndicator.shared().show()
                    GCD.async(.Background) {
                        let param = ["version_id": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""]
                        RegisterationService.shared().checkVersion(params: param) { (message, success, checkVersion) in
                            GCD.async(.Main) {
                                ActivityIndicator.shared().hide()
                                if success{
                                    print(success)
                                    AlertService().showAlert(title: "OTS Driver", message: "Please update your application to latest version to proceed", actionButtonTitle: "OK", completion: {
                                        if let url = URL(string:
                                            "https://itunes.apple.com/za/app/ots-driver-connect/id1504605928?mt=8"),
                                            //"itms-apps://itunes.apple.com/app/id\(kApplicationId)"),
                                            UIApplication.shared.canOpenURL(url)
                                        {
                                            if #available(iOS 10.0, *) {
                                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                            } else {
                                                UIApplication.shared.openURL(url)
                                            }
                                        }
                                    })
                                }else{
                                   print(message)
                                    self.apiCall([DictKeys.userName : self.emailTextfield.text!,
                                    DictKeys.password : self.passwordTextfield.text!,
                                    DictKeys.device_token : Global.shared.fcmToken,
                                    DictKeys.device_platform : "ios"])
                                }
                            }
                            
                        }
                    }
                }
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
