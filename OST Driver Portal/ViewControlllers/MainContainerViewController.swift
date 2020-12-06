//
//  MainContainerViewController.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 21/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

class MainContainerViewController: BaseViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var naviController: UINavigationController!
    weak var delegate: MainContainerViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShowHomeController()

    }
    
    func setTitleAndButton(title: String, isHideBtnBack: Bool = false, isHideBtnHome: Bool = false){
        self.lblTitle.text = title
        self.btnBack.isHidden = isHideBtnBack
        self.btnHome.isHidden = isHideBtnHome
    }
    
    func ShowHomeController(){
        let storyboard = UIStoryboard(name: StoryboardNames.Home, bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeNavVC") as! BaseNavigationController
        if let oldRef = self.naviController{
            oldRef.viewDidDisappear(true)
            oldRef.view.removeFromSuperview()
        }
        addChild(homeVC)
        homeVC.view.frame = self.containerView.bounds
        self.containerView.addSubview(homeVC.view)
        homeVC.didMove(toParent: self)
    }
    
    @IBAction func actionBack(_ sender: UIButton){
        if let delegate = self.delegate{
            delegate.callBack()
        }
    }
    
    @IBAction func actionHomeBack(_ sender: UIButton){
        delegate.callBackHome()
    }
    
    @IBAction func actionAddPlus(_ sender: UIButton){
        delegate.callAddController()
    }
    
    
    
    
}
