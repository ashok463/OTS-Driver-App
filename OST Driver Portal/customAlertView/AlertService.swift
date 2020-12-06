//
//  AlertService.swift
//  CustomAlertViewDemo
//
//  Created by Shashank Panwar on 04/07/19.
//  Copyright © 2019 Shashank Panwar. All rights reserved.
//

import UIKit

enum AlertType : Int{
    case informationAlertType
    case confirmationAlertType
}

class AlertService{
    
    private func alert(withtype type: AlertType,withTitle title : String, alertBody body : String, actionButtonTitle : String, completion : @escaping () -> Void ) -> AlertViewController{
        let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
        alertVC.alertTitle = title
        alertVC.alertBody = body
        alertVC.actionBtnTitle = actionButtonTitle
        alertVC.alertType = type
        alertVC.buttonAction = completion
        return alertVC
    }
    
    func showAlert(on vc: UIViewController? = nil, title : String, message : String, actionButtonTitle : String, completion : @escaping ()-> Void){
        let alertVC = alert(withtype: .informationAlertType, withTitle: title, alertBody: message, actionButtonTitle: actionButtonTitle, completion: completion)
        if vc != nil{
            vc?.present(alertVC, animated: true)
        }else{
            let presentedViewController = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController
            if presentedViewController == nil{
                let rootViewController = UIApplication.shared.keyWindow?.rootViewController
                rootViewController?.present(alertVC, animated: true)
            }else{
                presentedViewController?.present(alertVC, animated: true)
            }
            
        }
        
    }
    
}
