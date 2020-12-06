//
//  DispatchViewController.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 18/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit
import SideMenu
import SVProgressHUD

class DispatchViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var loadDetailBackView: UIView!
    @IBOutlet weak var pickupDeliveryBackview: UIView!
    @IBOutlet weak var lblInvoiceNumber: UILabel!
    @IBOutlet weak var lblDriver: UILabel!
    @IBOutlet weak var lblTruck: UILabel!
    @IBOutlet weak var lblTrailerNumber: UILabel!
    @IBOutlet weak var lblPickupDate: UILabel!
    @IBOutlet weak var lblPickupTime: UILabel!
    @IBOutlet weak var lblPickupFrom: UILabel!
    @IBOutlet weak var lblDeliveryDate: UILabel!
    @IBOutlet weak var lblDeliveryTime: UILabel!
    @IBOutlet weak var lblDeliveryTo: UILabel!
    @IBOutlet weak var lblLoadStatus: UILabel!
    @IBOutlet weak var lblNoFileChosen: UILabel!
    @IBOutlet weak var txtBol: UITextField!
    @IBOutlet weak var btnPickupDeliveryDetails: UIButton!
    @IBOutlet weak var btnChooseFile: UIButton!
    @IBOutlet weak var btnSubmitBol: UIButton!
    
    var dispatchObject = DispatchViewModel()
    var storeImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         loadDetailBackView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, cornerRadius: 10.0, radius: 5.0, edge: AIEdge.All, shadowSpace: 20)
        pickupDeliveryBackview.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, cornerRadius: 10.0, radius: 5.0, edge: AIEdge.All, shadowSpace: 20)
        //self.loadDispatchData()
        
        let params:ParamsAny = [DictKeys.driver_id:Global.shared.user!.id]
        self.apiCall(params)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if let container = self.mainContainer{
//            container.delegate = self
//            container.setTitleAndButton(title: TitleName.Dispatch, isHideBtnBack: false, isHideBtnHome: true)
//        }
//    }
    
    //MARK: - CUSTOM METHODS 
    fileprivate func loadDispatchData() {
        self.lblInvoiceNumber.text = self.dispatchObject.loadData.invoice_number
        self.lblDriver.text = self.dispatchObject.loadData.driver_name
        self.lblTruck.text = self.dispatchObject.loadData.truck_number
        self.lblTrailerNumber.text = self.dispatchObject.loadData.trailer_number
        self.lblPickupDate.text = self.dispatchObject.loadData.pickup_date
        self.lblPickupTime.text = self.dispatchObject.loadData.pickup_time
        self.lblPickupFrom.text = self.dispatchObject.loadData.pickup_from
        self.lblDeliveryDate.text = self.dispatchObject.loadData.delivery_date
        self.lblDeliveryTime.text = self.dispatchObject.loadData.delivery_time
        self.lblDeliveryTo.text = self.dispatchObject.loadData.delivery_to
        self.lblLoadStatus.text = self.dispatchObject.loadData.status
        
    }
    
    func apiCall(_ params: [String:Any] ){
            ActivityIndicator.shared().show()
    //            self.startActivityWithMessage()
                GCD.async(.Background) {
                    RegisterationService.shared().loadDataDetail(params: params) { (message, success, dispatchDataModel) in
                        ActivityIndicator.shared().hide()
    //                    self.stopActivity()
                        GCD.async(.Main) {
                            if success {
                                self.dispatchObject = dispatchDataModel!
                                self.loadDispatchData()
//                                self.navigateToDispatchDataScreen(dispatchDataModel!)
                            }else{
                                AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {
    //                            self.showAlertView(message: message)
                                })
                            }
                        }
                    }
                }
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
    
    @IBAction func actionPickupDeliveryDetail(_ sender: UIButton){
//        let storyboard = UIStoryboard(name: StoryboardNames.Detail, bundle: nil)
        let pickupDetailVC = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.PickupDetailsViewController) as! PickupDetailsViewController
        pickupDetailVC.dispatchData = self.dispatchObject
        self.navigationController?.pushViewController(pickupDetailVC, animated: true)
    }
    
    @IBAction func actionChooseFile(_ sender: UIButton) {
        getProfileImage()
    }
    
    @IBAction func actionSubmitBol(_ sender: UIButton) {
        if(self.txtBol.text!.isEmpty || self.storeImage == nil){
            AlertService().showAlert(title: "Alert", message: "Fill all fields. Both BOL number and reciept is required.", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "Fill all fields. Both BOL number and reciept is required.", title: "")
        }else{
            let params:[String:String] = [DictKeys.loadId : "\(dispatchObject.loadData.load_id)",
                DictKeys.companyId : dispatchObject.loadData.company_id,
                DictKeys.deliveryId : "\(dispatchObject.getLastDelieveryId())",
                DictKeys.bol : self.txtBol.text!]
            bolApiCall(params, and: storeImage!)
        }
    }
    
    func callBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getProfileImage(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
      //  actionSheet.addAction(.init(title: LocalStrings.UploadFile, style: .default, handler: { (UIAlertAction) in
            
       // }))
        actionSheet.addAction(.init(title: LocalStrings.Camera, style: .default, handler: { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion:  nil)
            }else{
                print(PopupMessages.cameraIsNotAvailable)
            }
        }))
        actionSheet.addAction(.init(title: LocalStrings.UploadFile, style: .default, handler: { (UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion:  nil)
        }))
        actionSheet.addAction(.init(title: LocalStrings.Cancel, style: .cancel, handler: { (UIAlertAction) in
            
        }))
        self.present(actionSheet, animated: true, completion:  nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.storeImage = image
        let url = info[UIImagePickerController.InfoKey.imageURL] as! URL
        let imageName = url.lastPathComponent
        self.lblNoFileChosen.text = imageName
        picker.dismiss(animated: true, completion: nil)
    }
    
    func bolApiCall(_ params: [String : String], and image:UIImage){
        ActivityIndicator.shared().show()
//        self.startActivityWithMessage()
        let imageDict = [DictKeys.bolUpload:image.jpegData(compressionQuality: 0.75)!]
        GCD.async(.Background) {
            RegisterationService.shared().uploadBol(params: params, dict: imageDict) { (message, success, json) in
                GCD.async(.Main) {
                    ActivityIndicator.shared().hide()
//                    self.stopActivity()
                    AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {})
//                    self.showAlertView(message: message)
                }
            }
        }
    }
    
    
}
