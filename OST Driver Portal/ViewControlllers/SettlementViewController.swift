//
//  SettlementViewController.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 28/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit
import SideMenu

class SettlementViewController: UIViewController{
//, MainContainerViewControllerDelegate {
    
    /* Ashok */
    @IBOutlet weak var tablevVewSettlement: UITableView!
    
    var arrayName = ["john","David","Methu","Channa"]
    
    var settlementObject = SettlementListViewModel()
    
    /* Ashok */
    var settlementData = SettlementListViewModel()
    
    var nextOffset = 0
    
    fileprivate var activityIndicator: LoadMoreActivityIndicator!

    private lazy var loaderMoreView: UIView = {
        let loaderView = UIActivityIndicatorView(style: .whiteLarge)
        loaderView.color = UIColor.gray
        loaderView.startAnimating()
        return loaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /* Ashok */
        activityIndicator = LoadMoreActivityIndicator(scrollView: tablevVewSettlement, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)

        settlementapiCall([DictKeys.driver_id : Global.shared.user?.id ?? kIntDefault])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        mainContainer?.delegate = self
//        mainContainer?.setTitleAndButton(title: "Settlement", isHideBtnBack: false, isHideBtnHome: true)
//
        //settlementapiCall([DictKeys.driver_id : Global.shared.user?.id ?? kIntDefault])
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
//                                AlertService().showAlert(title: "OTS Driver", message: message, actionButtonTitle: "OK", completion: {
    //                            let storyBoard = UIStoryboard(name: StoryboardNames.Popup, bundle: nil)
//                                    if #available(iOS 13.0, *) {
//                                        let settlementVC = self.storyboard?.instantiateViewController(identifier: "SettlementViewController") as? SettlementViewController
//                                        settlementVC?.settlementObject = settlementDataModel!
//                                        self.navigationController?.pushViewController(settlementVC!, animated: true)
//                                    } else {
//                                        // Fallback on earlier versions
//                                        let settlementVC = self.storyboard?.instantiateViewController(withIdentifier: "SettlementViewController") as? SettlementViewController
//                                        settlementVC?.settlementObject = settlementDataModel!
//                                        self.navigationController?.pushViewController(settlementVC!, animated: true)
//                                    }
//                                })
    //                            self.showAlertView(message: message)
                                self.settlementObject = settlementDataModel!
                                self.addElements()
                                self.tablevVewSettlement.reloadData()
                            }else{
                                AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {})
    //                            self.showAlertView(message: message)
                            }
                            
                        }
                    }
                }
            }
    
    /* Ashok */
    func addElements() {
        print("count data settlement: \(settlementObject.settlementList.count)")
        let newOffset = nextOffset+20
        print("nextOffset: \(nextOffset)")
        print("newOffset: \(newOffset)")
        for i in nextOffset..<newOffset {
            print("settlement index data : \(i)")
            if i < settlementObject.settlementList.count{
                settlementData.settlementList.append(settlementObject.settlementList[i])
                nextOffset = newOffset
            }else{
                AlertService().showAlert(title: "Alert", message: "No more load data found", actionButtonTitle: "OK", completion: {})
//                showAlertView(message: "No more load data found", title: "Alert")
            }
            
        }
    }
    
    /* Ashok */
    func addData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.addElements()
            self.tablevVewSettlement.reloadData()
        }
    }

    /* Ashok */
    func setUpLoaderView(toShow: Bool) {
        if toShow {
            self.tablevVewSettlement.tableFooterView?.isHidden = false
            self.tablevVewSettlement.tableFooterView = self.loaderMoreView
        } else {
            self.tablevVewSettlement.tableFooterView = UIView()
        }
    }
    
    func callBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func menuBtnAction(_ sender: UIButton) {
        // Define the menu
        let menu = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") as? SideMenuNavigationController
        menu?.enableSwipeToDismissGesture = true
        menu?.leftSide = false
        present(menu!, animated: true, completion: nil)
    }
}
//MARK: - EXTENSION TABLE VIEW METHOD
extension SettlementViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settlementData.settlementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let settlementCell = tableView.dequeueReusableCell(withIdentifier: "settlementCell") as! SettlementTableViewCell
        settlementCell.configure(data: settlementData.settlementList[indexPath.row])
        return settlementCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 390
        
        
    }
    
    /* Ashok */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentCount = self.settlementData.settlementList.count
        if currentCount < self.settlementObject.settlementList.count && indexPath.row == (currentCount-1) { //last row
            self.addData()
            self.setUpLoaderView(toShow: true)
        } else {
            self.setUpLoaderView(toShow: false)
        }
    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        activityIndicator.start {
//            DispatchQueue.global(qos: .utility).async {
//                for i in 0..<3 {
//                    print("!!!!!!!!! \(i)")
//                    sleep(1)
//                }
//                DispatchQueue.main.async { [weak self] in
//                    self?.activityIndicator.stop()
//                }
//            }
//        }
//    }
}

