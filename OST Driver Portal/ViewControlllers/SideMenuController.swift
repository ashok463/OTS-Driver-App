//
//  SideMenuController.swift
//  OTS Manager
//
//  Created by Ashok Kumar on 20/08/20.
//  Copyright © 2020 Ashok Kumar. All rights reserved.
//

import UIKit

class SideMenuController: UIViewController {
    
    @IBOutlet weak var imgViewUser: UIImageView!
    @IBOutlet weak var topConstraintUserImg: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintUserImg: NSLayoutConstraint!
    @IBOutlet weak var widthConstraintUserImg: NSLayoutConstraint!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var roleLbl: UILabel!
    @IBOutlet weak var menuTableView: UITableView!
    
    var itemsData = ["Home", "Dispatch", "Expense", "Settlement", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            
            //            topConstraintUserImg.constant = 60
            heightConstraintUserImg.constant = 200
            widthConstraintUserImg.constant = 200
            nameLbl.font = nameLbl.font.withSize(40)
        }else{
            
            //            topConstraintUserImg.constant = 30
            heightConstraintUserImg.constant = 100
            widthConstraintUserImg.constant = 100
            nameLbl.font = nameLbl.font.withSize(20)
        }
        
        imgViewUser.cornerRadiusWithBoarderImageView(radius: imgViewUser.frame.size.height/2, color: .white, width: 1.0)
        menuTableView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, cornerRadius: 0.0, radius: 2, edge: .All, shadowSpace: 20 )
        menuTableView.dataSource = self
        menuTableView.delegate = self
        
        nameLbl.text = Global.shared.user?.driver_name
        roleLbl.text = Global.shared.user?.username
        imgViewUser.sd_setImage(with: URL(string: Global.shared.user?.profile_image ?? ""), placeholderImage: UIImage(named: "logoWhite_ic"))
    }
    
    @IBAction func crossBtnAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editBtnAction(_ sender: UIButton) {
        
//        if #available(iOS 13.0, *) {
//            let editProfileVC = (storyboard?.instantiateViewController(identifier: "EditProfileVC") as? EditProfileVC)!
//            self.navigationController?.pushViewController(editProfileVC, animated: true)
//        } else {
//            // Fallback on earlier versions
//            let editProfileVC = storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC
//            self.navigationController?.pushViewController(editProfileVC!, animated: true)
//        }
    }
    
}

extension SideMenuController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuCell = menuTableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as? MenuTableViewCell
        menuCell?.itemNameLbl.text = itemsData[indexPath.row]
        return menuCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            if #available(iOS 13.0, *) {
                guard let kYDrawerController = storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else {return}
                self.navigationController?.pushViewController(kYDrawerController, animated: true)
            } else {
                // Fallback on earlier versions
                guard let kYDrawerController = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {return}
                self.navigationController?.pushViewController(kYDrawerController, animated: true)
            }
        }
        
        if indexPath.row == 1{
            if #available(iOS 13.0, *) {
                let dispatchVC = (storyboard?.instantiateViewController(identifier: "DispatchViewController") as? DispatchViewController)!
                self.navigationController?.pushViewController(dispatchVC, animated: true)
            } else {
                // Fallback on earlier versions
                let dispatchVC = storyboard?.instantiateViewController(withIdentifier: "DispatchViewController") as? DispatchViewController
                self.navigationController?.pushViewController(dispatchVC!, animated: true)
            }
        }
        if indexPath.row == 2{
            if #available(iOS 13.0, *) {
                let expenseVC = storyboard?.instantiateViewController(identifier: "ExpenseViewController") as? ExpenseViewController
                self.navigationController?.pushViewController(expenseVC!, animated: true)
            } else {
                // Fallback on earlier versions
                let expenseVC = storyboard?.instantiateViewController(withIdentifier: "ExpenseViewController") as? ExpenseViewController
                self.navigationController?.pushViewController(expenseVC!, animated: true)
            }
        }
        if indexPath.row == 3{
            if #available(iOS 13.0, *) {
                let settlementVC = storyboard?.instantiateViewController(identifier: "SettlementViewController") as? SettlementViewController
                self.navigationController?.pushViewController(settlementVC!, animated: true)
            } else {
                // Fallback on earlier versions
                let settlementVC = storyboard?.instantiateViewController(withIdentifier: "SettlementViewController") as? SettlementViewController
                self.navigationController?.pushViewController(settlementVC!, animated: true)
            }
        }
        if indexPath.row == 4{
            //            if #available(iOS 13.0, *) {
            //                let dispatchVC = storyboard?.instantiateViewController(identifier: "DispatchVC") as? DispatchVC
            //                self.navigationController?.pushViewController(dispatchVC!, animated: true)
            //            } else {
            //                // Fallback on earlier versions
            //                let dispatchVC = storyboard?.instantiateViewController(withIdentifier: "DispatchVC") as? DispatchVC
            //                self.navigationController?.pushViewController(dispatchVC!, animated: true)
            //            }
            
            // create the alert
            let alert = UIAlertController(title: "Logout", message: "Are you sure you want to Logout?", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                if #available(iOS 13.0, *) {
                    let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
                    UserDefaultsManager.shared.clearUserData()
                    self.navigationController?.pushViewController(loginVC!, animated: true)
                } else {
                    // Fallback on earlier versions
                    let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
                    UserDefaultsManager.shared.clearUserData()
                    self.navigationController?.pushViewController(loginVC!, animated: true)
                }
            }))
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        //        if indexPath.row == 4{
        //            if #available(iOS 13.0, *) {
        //                let permitsVC = storyboard?.instantiateViewController(identifier: "PermitsVC") as? PermitsVC
        //                permitsVC?.topTitle = "Reports"
        //                self.navigationController?.pushViewController(permitsVC!, animated: true)
        //            } else {
        //                // Fallback on earlier versions
        //                let permitsVC = storyboard?.instantiateViewController(withIdentifier: "PermitsVC") as? PermitsVC
        //                permitsVC?.topTitle = "Reports"
        //                self.navigationController?.pushViewController(permitsVC!, animated: true)
        //            }
        //        }
        //        if indexPath.row == 5{
        ////            if #available(iOS 13.0, *) {
        ////                let dispatchVC = storyboard?.instantiateViewController(identifier: "DispatchVC") as? DispatchVC
        ////                self.navigationController?.pushViewController(dispatchVC!, animated: true)
        ////            } else {
        ////                // Fallback on earlier versions
        ////                let dispatchVC = storyboard?.instantiateViewController(withIdentifier: "DispatchVC") as? DispatchVC
        ////                self.navigationController?.pushViewController(dispatchVC!, animated: true)
        ////            }
        //        }
        //
        //        if indexPath.row == 6{
        //
        //
        //        }
        
    }
    
}
