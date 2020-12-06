//
//  PickupDetailsViewController.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 19/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

class PickupDetailsViewController: UIViewController, PickupDetailsTableViewCellDelegate{
//,MainContainerViewControllerDelegate, PickupDetailsTableViewCellDelegate{
   
    
    
    @IBOutlet weak var lblPickupLine: UILabel!
    @IBOutlet weak var lblDeliveryLine: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var isPickup: Bool = true
    var dispatchData:DispatchViewModel!
    var cellHeights: [IndexPath: CGFloat?] = [:]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        
//        if let container = self.mainContainer{
//            container.delegate = self
//           container.setTitleAndButton(title: TitleName.PickupsDelivery, isHideBtnBack: false, isHideBtnHome: false)
//        }
//        
        self.lblDeliveryLine.isHidden = true
        if(self.dispatchData.shouldShowPickupButton){
            self.actionPickup(UIButton())
        }else{
            self.actionDelivery(UIButton())
        }
    }

    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- ACTION METHODS
    @IBAction func actionPickup(_ sender: UIButton){
        isPickup = true
        self.lblDeliveryLine.isHidden = true
        self.lblPickupLine.isHidden = false
        self.tableView.reloadData()
    }
    
    @IBAction func actionDelivery(_ sender: UIButton){
        isPickup = false
        self.lblPickupLine.isHidden = true
        self.lblDeliveryLine.isHidden = false
        self.tableView.reloadData()
    }
    //MARK: - FUNCTION
    func callBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func callapiCall(_ isDelivery:Bool, delivery:DeliveryViewModel?, pickup:PickupViewModel?) {
        if isDelivery {
            if self.dispatchData.isLastToDeliever() {
                print(delivery?.id)
//                let storyboard = UIStoryboard(name: StoryboardNames.Home, bundle: nil)
                let uploadBolVC = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.UploadBolViewController) as! UploadBolViewController
                uploadBolVC.dispatchObject = self.dispatchData
                uploadBolVC.statusParam = "1"
                uploadBolVC.delivery = delivery
                uploadBolVC.pickup = pickup
                uploadBolVC.isDelivery = isDelivery
                self.navigationController?.pushViewController(uploadBolVC, animated: true)
//                showAlertView(message: "Please submit your BOL first", title: "")
            }else {
               
//                let storyboard = UIStoryboard(name: StoryboardNames.Home, bundle: nil)
                let uploadBolVC = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.UploadBolViewController) as! UploadBolViewController
                uploadBolVC.dispatchObject = self.dispatchData
                uploadBolVC.statusParam = "0"
                uploadBolVC.delivery = delivery
                uploadBolVC.pickup = pickup
                uploadBolVC.isDelivery = isDelivery
                self.navigationController?.pushViewController(uploadBolVC, animated: true)
//               apiCallPickupDeliveryStatus(params: [DictKeys.id : delivery?.id ?? kIntDefault], isDelivery, delivery, pickup)
            }
        }else {
            apiCallPickupDeliveryStatus(params: [DictKeys.id : pickup?.id ?? kIntDefault], isDelivery, delivery, pickup)
        }
        
    }
    
    func callBackActionDirection(index: Int) {
        showMap(index: index)
        print("direction Button")
    }
    func callBackHome() {
        for controller in self.navigationController?.viewControllers ?? [] {
            if controller.isKind(of: HomeViewController.self) {
                self.navigationController?.popToViewController(controller, animated: true)
            }
        }
    }
    
    func showMap(index : Int){
        var address = ""
        if isPickup {
            address = self.dispatchData.pikups.pickupList[index].address
        }else {
            address = self.dispatchData.deliverys.deliveryList[index].address
        }
        
        if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!){
            let urlString = "http://maps.google.com/?daddr=\(address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&directionsmode=driving"
            //UIApplication.shared.openURL(URL(string: urlString)!)
            UIApplication.shared.open(URL(string: urlString)!, options: [:], completionHandler: nil)
        }else{
            let urlString = "http://maps.apple.com/maps?daddr=\(address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&dirflg=d"
            // UIApplication.shared.openURL(URL(string: urlString)!)
            UIApplication.shared.open(URL(string: urlString)!, options: [:], completionHandler: nil)
        }
    }
    
    //MARK:- API CALLS
    func apiCallPickupDeliveryStatus(params: [String:Any], _ isDelivery:Bool,_ delivery:DeliveryViewModel?, _ pickup:PickupViewModel?){
        ActivityIndicator.shared().show()
//        self.startActivityWithMessage()
        GCD.async(.Background) {
            RegisterationService.shared().PickupDeliveryStatus(params: params) { (message, success, json) in
                GCD.async(.Main) {
                    ActivityIndicator.shared().hide()
//                    self.stopActivity()
                    AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {})
//                    self.showAlertView(message: message)
                    if(isDelivery){
                        delivery?.status = "1"
                        delivery?.status_message = "Delivery Done"
                        delivery?.shouldShowButton = false
                    }else{
                        pickup?.status = "1"
                        pickup?.status_message = "Pickup Done"
                        pickup?.shouldShowButton = false
                    }
                    self.dispatchData.checkForPickupsDeliveries()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}
//MARK:- EXTENSION TABLE VIEW METHOD
extension PickupDetailsViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isPickup){
            return self.dispatchData.pikups.pickupList.count
        }else{
            return self.dispatchData.deliverys.deliveryList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pickupCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.pickupDetailCell) as! PickupDetailsTableViewCell
        pickupCell.self.lbl1.text = "\(indexPath.row + 1)"
        pickupCell.delegate = self
        pickupCell.index = indexPath.row
        if isPickup {
            let pickup = self.dispatchData.pikups.pickupList[indexPath.row]
            let hidden = !(self.dispatchData.shouldShowPickupButton && pickup.shouldShowButton)
            pickupCell.configure(with: pickup, deliveryOption: hidden)
        }else{
            let delivery = self.dispatchData.deliverys.deliveryList[indexPath.row]
            let hidden = !(self.dispatchData.shouldShowDeliveryButton && delivery.shouldShowButton)
            pickupCell.configure(with: delivery, deliveryOption: hidden)
        }
        return pickupCell
    }
    
    /* Ashok */
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if let height = cellHeights[indexPath] {
//            return height ?? UITableView.automaticDimension
//        }
//        return UITableView.automaticDimension
//
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.height
        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
