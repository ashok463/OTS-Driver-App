//
//  HomeViewController.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 17/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit
import SideMenu
import SDWebImage

class HomeViewController: UIViewController {
    
    //    @IBOutlet weak var lblWelcome: UILabel!
    //    @IBOutlet weak var btnSwitch: UIButton!
    //    @IBOutlet weak var btnDispatch: UIButton!
    //    @IBOutlet weak var btnExpense: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dispatchBackView: UIView!
    @IBOutlet weak var expenseBackView: UIView!
    @IBOutlet weak var settlementBackView: UIView!
    
    //IBOutlets
    @IBOutlet weak var userImgBackgroundView: UIView!
    @IBOutlet weak var heightUserImgBackgroundView: NSLayoutConstraint!
    @IBOutlet weak var widthUserImgBackgroundView: NSLayoutConstraint!
    
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var heightStatusBtn: NSLayoutConstraint!
    @IBOutlet weak var widthStatusBtn: NSLayoutConstraint!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var roleLbl: UILabel!
    
    //    @IBOutlet weak var despatchBtnbackgroundView: UIView!
    //    @IBOutlet weak var expenseBtnBackgroundView: UIView!
    //    @IBOutlet weak var settlementBtnBackgroundView: UIView!
    
    @IBOutlet weak var despatchImgBackgroundView: UIView!
    @IBOutlet weak var expenseImgBackgroundView: UIView!
    @IBOutlet weak var settlementImgBackgroundView: UIView!
    
    
    @IBOutlet weak var dispatchBtn: UIButton!
    @IBOutlet weak var expenseBtn: UIButton!
    @IBOutlet weak var settlementBtn: UIButton!
    @IBOutlet weak var heightDespatchBtnView: NSLayoutConstraint!
    @IBOutlet weak var heightExpenseBtnView: NSLayoutConstraint!
    @IBOutlet weak var heightSettlementBtnView: NSLayoutConstraint!
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var widthConstraintMenuBtn: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintMenuBtn: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatchBackView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, cornerRadius: 10.0, radius: 5.0, edge: AIEdge.All, shadowSpace: 20)
        expenseBackView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, cornerRadius: 10.0, radius: 5.0, edge: AIEdge.All, shadowSpace: 20)
        settlementBackView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, cornerRadius: 10.0, radius: 5.0, edge: AIEdge.All, shadowSpace: 20)
        //        userImgBackgroundView.cornerRadius(radius: userImgBackgroundView.frame.size.height/2)
        userImgView.cornerRadiusWithBoarderImageView(radius: userImgView.frame.height/2, color: .white, width: 1.0)
        statusBtn.cornerRadiusWithBoarderBtn(radius: statusBtn.frame.size.height/2, color: .white, width: 1.0)
        //        despatchBtnbackgroundView.cornerRadius(radius: 10)
        //        expenseBtnBackgroundView.cornerRadius(radius: 10)
        //        settlementBtnBackgroundView.cornerRadius(radius: 10)
        despatchImgBackgroundView.cornerRadius(radius: despatchImgBackgroundView.frame.size.height/2)
        expenseImgBackgroundView.cornerRadius(radius: expenseImgBackgroundView.frame.size.height/2)
        settlementImgBackgroundView.cornerRadius(radius: settlementImgBackgroundView.frame.size.height/2)
        
        userNameLbl.text = Global.shared.user?.driver_name
        roleLbl.text = Global.shared.user?.username
        userImgView.sd_setImage(with: URL(string: Global.shared.user?.profile_image ?? ""), placeholderImage: UIImage(named: "logoWhite_ic"))
        
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
        super.viewWillAppear(animated)
        self.apicallCheckToken()
        //        if let continer = self.mainContainer{
        //            continer.delegate = self
        ////            lblWelcome.text = "Welcome \((Global.shared.user?.driver_name ?? "Admin"))"
        //            continer.setTitleAndButton(title: TitleName.Dashboard, isHideBtnBack: true, isHideBtnHome: true)
        //
        //        }
    }
    
    //MARK:- Custom methods
    fileprivate func navigateToDispatchDataScreen(_ data:DispatchViewModel) {
        //        let dispatchVC = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.DispatchViewController) as! DispatchViewController
        //        dispatchVC.dispatchObject = data
        //        self.navigationController?.pushViewController(dispatchVC, animated: true)
        if #available(iOS 13.0, *) {
            let dispatchViewController = storyboard?.instantiateViewController(identifier: "DispatchViewController") as? DispatchViewController
            dispatchViewController?.dispatchObject = data
            self.navigationController?.pushViewController(dispatchViewController!, animated: true)
        } else {
            // Fallback on earlier versions
            let dispatchViewController = storyboard?.instantiateViewController(withIdentifier: "DispatchViewController") as? DispatchViewController
            dispatchViewController?.dispatchObject = data
            self.navigationController?.pushViewController(dispatchViewController!, animated: true)
        }
    }
    
    @IBAction func dispatchBtnAction(_ sender: UIButton) {
        
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
                        let params:ParamsAny = [DictKeys.driver_id:Global.shared.user?.id ?? ""]
                        self.apiCall(params)
                    }
                }
                
            }
        }
    }
    
    @IBAction func expenseBtnAction(_ sender: UIButton) {
        
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
                        let expenseVC = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.ExpenseViewController) as! ExpenseViewController
                        self.navigationController?.pushViewController(expenseVC, animated: true)
                    }
                }
                
            }
        }
        
    }
    
    @IBAction func settlementBtnAction(_ sender: UIButton) {
        
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
                        self.settlementapiCall([DictKeys.driver_id : Global.shared.user?.id ?? kIntDefault])
                    }
                }
                
            }
        }
        
    }
    
    
    @IBAction func menuBtnAction(_ sender: UIButton) {
        
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
                        let menu = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") as? SideMenuNavigationController
                        menu?.enableSwipeToDismissGesture = true
                        self.present(menu!, animated: true, completion: nil)
                    }
                }
                
            }
        }
    }
    
    @IBAction func notificationBtnAction(_ sender: UIButton) {
        
    }
    
    //MARK: - ACTION METHODS
    @IBAction func actionLogout(_ sender: UIButton){
        let storyboard = UIStoryboard(name: StoryboardNames.Registration, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: ControllerIdentifier.LoginViewController) as? LoginViewController{
            UserDefaultsManager.shared.clearUserData()
            
            self.navigationController?.navigationController?.pushViewController(vc, animated: true)
            //            self.showAlertView(message: "Logout Successfully.")
        }
    }
    @IBAction func actionDispatch(_ sender: UIButton) {
        let params:ParamsAny = [DictKeys.driver_id:Global.shared.user!.id]
        self.apiCall(params)
    }
    
    @IBAction func actionExpense(_ sender: UIButton) {
        //        let expenseVC = storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.ExpenseViewController) as! ExpenseViewController
        //        self.navigationController?.pushViewController(expenseVC, animated: true)
        if #available(iOS 13.0, *) {
            let expenseViewController = storyboard?.instantiateViewController(identifier: "ExpenseViewController") as? ExpenseViewController
            self.navigationController?.pushViewController(expenseViewController!, animated: true)
        } else {
            // Fallback on earlier versions
            let expenseViewController = storyboard?.instantiateViewController(withIdentifier: "ExpenseViewController") as? ExpenseViewController
            self.navigationController?.pushViewController(expenseViewController!, animated: true)
        }
    }
    
    @IBAction func actionSettlement(_ sender: UIButton){
        settlementapiCall([DictKeys.driver_id : Global.shared.user?.id ?? kIntDefault])
        
    }
    
    func callBack() {
        
    }
    
}

//MARK:- API Calls
extension HomeViewController {
    func apiCall(_ params: [String:Any] ){
        ActivityIndicator.shared().show()
        //            self.startActivityWithMessage()
        GCD.async(.Background) {
            RegisterationService.shared().loadDataDetail(params: params) { (message, success, dispatchDataModel) in
                ActivityIndicator.shared().hide()
                //                    self.stopActivity()
                GCD.async(.Main) {
                    if success {
                        self.navigateToDispatchDataScreen(dispatchDataModel!)
                    }else{
                        AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {
                            //                            self.showAlertView(message: message)
                        })
                    }
                }
            }
        }
    }
    
    func apicallCheckToken(){
        GCD.async(.Background) {
            RegisterationService.shared().checkToken { (message, success, json) in
                GCD.async(.Main) {
                    if success{
                        print("Session check successfull")
                    }else{
                        //                            self.showAlertView(message: "Session expired, go back and login again", title: ALERT_TITLE_APP_NAME, doneButtonTitle: LocalStrings.OK) { (_) in
                        UserDefaultsManager.shared.clearUserData()
                        let storyboard = UIStoryboard(name: StoryboardNames.Registration, bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: ControllerIdentifier.LoginViewController) as! LoginViewController
                        self.navigationController?.navigationController?.setViewControllers([controller], animated: true)
                        self.navigationController?.navigationController?.popToRootViewController(animated: true)
                        //                            }
                    }
                }
            }
        }
    }
    
    func settlementapiCall(_ params: [String:Any]){
        ActivityIndicator.shared().show()
        //            self.startActivityWithMessage()
        GCD.async(.Background) {
            RegisterationService.shared().settlementDetail(params: params) { (message, success,settlementDataModel) in
                GCD.async(.Main) {
                    ActivityIndicator.shared().hide()
                    //                        self.stopActivity()
                    if success{
                        //                            AlertService().showAlert(title: "OTS Driver", message: message, actionButtonTitle: "OK", completion: {
                        //                            let storyBoard = UIStoryboard(name: StoryboardNames.Popup, bundle: nil)
                        if #available(iOS 13.0, *) {
                            let settlementVC = self.storyboard?.instantiateViewController(identifier: "SettlementViewController") as? SettlementViewController
                            settlementVC?.settlementObject = settlementDataModel!
                            self.navigationController?.pushViewController(settlementVC!, animated: true)
                        } else {
                            // Fallback on earlier versions
                            let settlementVC = self.storyboard?.instantiateViewController(withIdentifier: "SettlementViewController") as? SettlementViewController
                            settlementVC?.settlementObject = settlementDataModel!
                            self.navigationController?.pushViewController(settlementVC!, animated: true)
                        }
                        //                            })
                        //                            self.showAlertView(message: message)
                    }else{
                        AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {})
                        //                            self.showAlertView(message: message)
                    }
                }
            }
        }
    }
}

