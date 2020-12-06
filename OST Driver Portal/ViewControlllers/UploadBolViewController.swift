//
//  UploadBolViewController.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 14/03/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit
import WeScan
import MobileCoreServices

class UploadBolViewController: UIViewController{
//, MainContainerViewControllerDelegate {
    
    
    @IBOutlet weak var lblNoFileChosen: UILabel!
    @IBOutlet weak var txtBol: UITextField!
    @IBOutlet weak var btnChooseFile: UIButton!
    @IBOutlet weak var btnSubmitBol: UIButton!
    
    /* Ashok */
    @IBOutlet weak var uploadImageBackgroundView1: UIView!
    @IBOutlet weak var uploadImageBackgroundView2: UIView!
    @IBOutlet weak var uploadImageBackgroundView3: UIView!
    @IBOutlet weak var uploadImageBackgroundView4: UIView!
    @IBOutlet weak var uploadImageBackgroundView5: UIView!
    
    @IBOutlet weak var chooseBtn1: UIButton!
    @IBOutlet weak var chooseBtn2: UIButton!
    @IBOutlet weak var chooseBtn3: UIButton!
    @IBOutlet weak var chooseBtn4: UIButton!
    @IBOutlet weak var chooseBtn5: UIButton!
    @IBOutlet weak var chooseFileLbl1: UILabel!
    @IBOutlet weak var chooseFileLbl2: UILabel!
    @IBOutlet weak var chooseFileLbl3: UILabel!
    @IBOutlet weak var chooseFileLbl4: UILabel!
    @IBOutlet weak var chooseFileLbl5: UILabel!
    
    
    @IBOutlet weak var topConstrainsuploadImageBackgroundView1: NSLayoutConstraint!
    @IBOutlet weak var topConstrainsuploadImageBackgroundView2: NSLayoutConstraint!
    @IBOutlet weak var topConstrainsuploadImageBackgroundView3: NSLayoutConstraint!
    @IBOutlet weak var topConstrainsuploadImageBackgroundView4: NSLayoutConstraint!
    @IBOutlet weak var topConstrainsuploadImageBackgroundView5: NSLayoutConstraint!
    
    @IBOutlet weak var addMoreImagesBtn: UIButton!
    @IBOutlet weak var heightConstraintAddMoreImagesBtn: NSLayoutConstraint!
    
    @IBOutlet weak var editmgbtn: UIButton!
    
    var dispatchObject = DispatchViewModel()
    var delivery:DeliveryViewModel!
    var pickup:PickupViewModel!
    var isDelivery = Bool()
    var storeImage: UIImage?
    var  uploadBtnindex = 0
    var statusParam = String()
    var storeImage0: Data?
    var storeImage1: Data?
    var storeImage2: Data?
    var storeImage3: Data?
    var storeImage4: Data?
    var storeImage5: Data?
    var storeImageCount = Int()
    var selectImagePdf = String()
    var removeBtnStatus1 = Bool()
    var removeBtnStatus2 = Bool()
    var removeBtnStatus3 = Bool()
    var removeBtnStatus4 = Bool()
    var removeBtnStatus5 = Bool()
    var allImageStore = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        topConstrainsuploadImageBackgroundView1.constant = 0
        topConstrainsuploadImageBackgroundView2.constant = 0
        topConstrainsuploadImageBackgroundView3.constant = 0
        topConstrainsuploadImageBackgroundView4.constant = 0
        topConstrainsuploadImageBackgroundView5.constant = 0
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if let container = self.mainContainer{
//            container.delegate = self
//            container.setTitleAndButton(title: TitleName.UploadBol, isHideBtnBack: false, isHideBtnHome: false)
//        }
//    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /* Ashok */
    @IBAction func removeBtn1Action(_ sender: UIButton) {
        
        topConstrainsuploadImageBackgroundView1.constant = 0
        heightConstraintAddMoreImagesBtn.constant = 50
        removeBtnStatus1 = true
        if chooseFileLbl1.text == "No file chosen"{
            chooseFileLbl1.text = "No file chosen"
        }else{
            chooseFileLbl1.text = "No file chosen"
            storeImage1 = nil
        }
    }
    
    /* Ashok */
    @IBAction func removeBtn2Action(_ sender: UIButton) {
        
        topConstrainsuploadImageBackgroundView2.constant = 0
        heightConstraintAddMoreImagesBtn.constant = 50
        removeBtnStatus2 = true
        if chooseFileLbl2.text == "No file chosen"{
            chooseFileLbl2.text = "No file chosen"
        }else{
            chooseFileLbl2.text = "No file chosen"
            storeImage2 = nil
        }
    }
    
    /* Ashok */
    @IBAction func removeBtn3Action(_ sender: UIButton) {
        
        topConstrainsuploadImageBackgroundView3.constant = 0
        heightConstraintAddMoreImagesBtn.constant = 50
        removeBtnStatus3 = true
        if chooseFileLbl3.text == "No file chosen"{
            chooseFileLbl3.text = "No file chosen"
        }else{
            chooseFileLbl3.text = "No file chosen"
            
            storeImage3 = nil
        }
    }
    
    /* Ashok */
    @IBAction func removeBtn4Action(_ sender: UIButton) {
        
        topConstrainsuploadImageBackgroundView4.constant = 0
        heightConstraintAddMoreImagesBtn.constant = 50
        removeBtnStatus4 = true
        if chooseFileLbl4.text == "No file chosen"{
            chooseFileLbl4.text = "No file chosen"
        }else{
            chooseFileLbl4.text = "No file chosen"
            
            storeImage4 = nil
        }
    }
    
    /* Ashok */
    @IBAction func removeBtn5Action(_ sender: UIButton) {
        
        topConstrainsuploadImageBackgroundView5.constant = 0
        heightConstraintAddMoreImagesBtn.constant = 50
        removeBtnStatus5 = true
        if chooseFileLbl5.text == "No file chosen"{
            chooseFileLbl5.text = "No file chosen"
        }else{
            chooseFileLbl5.text = "No file chosen"
            
            storeImage5 = nil
        }
    }
    
    /* Ashok */
    @IBAction func addMoreImagesBtnAction(_ sender: UIButton) {
        
        if lblNoFileChosen.text != "No file chosen"{
            topConstrainsuploadImageBackgroundView1.constant = 50
            if chooseFileLbl1.text != "No file chosen"{
                topConstrainsuploadImageBackgroundView2.constant = 50
                if chooseFileLbl2.text != "No file chosen"{
                    topConstrainsuploadImageBackgroundView3.constant = 50
                    if chooseFileLbl3.text != "No file chosen"{
                        topConstrainsuploadImageBackgroundView4.constant = 50
                        if chooseFileLbl4.text != "No file chosen"{
                            topConstrainsuploadImageBackgroundView5.constant = 50
                        }else{
                            //                    showAlertView(message: "Please choose the image/file", title: "Alert")
                            //                       topConstrainsuploadImageBackgroundView3.constant = 0
                        }
                    }else{
                        //                    showAlertView(message: "Please choose the image/file", title: "Alert")
                        //                       topConstrainsuploadImageBackgroundView3.constant = 0
                    }
                }else{
                    //                    showAlertView(message: "Please choose the image/file", title: "Alert")
                    //                       topConstrainsuploadImageBackgroundView3.constant = 0
                }
            }else{
                //                   topConstrainsuploadImageBackgroundView2.constant = 0
                //                   topConstrainsuploadImageBackgroundView3.constant = 0
                //                   showAlertView(message: "Please choose the image/file", title: "Alert")
            }
        }else{
            //               topConstrainsuploadImageBackgroundView1.constant = 0
            //               topConstrainsuploadImageBackgroundView2.constant = 0
            //               topConstrainsuploadImageBackgroundView3.constant = 0
            //               showAlertView(message: "Please choose the image/file", title: "Alert")
        }
        
        if removeBtnStatus1{
            removeBtnStatus1 = false
            if lblNoFileChosen.text != "No file chosen"{
                topConstrainsuploadImageBackgroundView1.constant = 50
            }
        }
        
        if removeBtnStatus2{
            removeBtnStatus2 = false
            if chooseFileLbl1.text != "No file chosen"{
                topConstrainsuploadImageBackgroundView2.constant = 50
            }
        }
        
        if removeBtnStatus3{
            removeBtnStatus3 = false
            if chooseFileLbl2.text != "No file chosen"{
                topConstrainsuploadImageBackgroundView3.constant = 50
            }
        }
        
        if removeBtnStatus4{
            removeBtnStatus4 = false
            if chooseFileLbl3.text != "No file chosen"{
                topConstrainsuploadImageBackgroundView4.constant = 50
            }
        }
        
        if removeBtnStatus5{
            removeBtnStatus5 = false
            if chooseFileLbl4.text != "No file chosen"{
                topConstrainsuploadImageBackgroundView5.constant = 50
            }
        }
        
        
        if lblNoFileChosen.text != "No file chosen" && chooseFileLbl1.text != "No file chosen" && chooseFileLbl2.text != "No file chosen" && chooseFileLbl3.text != "No file chosen" && chooseFileLbl4.text != "No file chosen" && chooseFileLbl5.text != "No file chosen" {
            heightConstraintAddMoreImagesBtn.constant = 0
            AlertService().showAlert(title: "Alert", message: "you can add upto maximum 6 pages", actionButtonTitle: "OK", completion: {})
//            showAlertView(message: "you can add upto maximum 6 pages", title: "Alert")
        }else{
            heightConstraintAddMoreImagesBtn.constant = 50
        }
    }
    
    /* Ashok */
    @IBAction func chooseBtn1Action(_ sender: UIButton) {
        uploadBtnindex = 1
        getProfileImage()
    }
    
    /* Ashok */
    @IBAction func chooseBtn2Action(_ sender: UIButton) {
        uploadBtnindex = 2
        getProfileImage()
    }
    
    /* Ashok */
    @IBAction func chooseBtn3Action(_ sender: UIButton) {
        uploadBtnindex = 3
        getProfileImage()
    }
    
    /* Ashok */
    @IBAction func chooseBtn4Action(_ sender: UIButton) {
        uploadBtnindex = 4
        getProfileImage()
    }
    
    /* Ashok */
    @IBAction func chooseBtn5Action(_ sender: UIButton) {
        uploadBtnindex = 5
        getProfileImage()
    }
    
    
    /* Ashok */
    @IBAction func actionChooseFile(_ sender: UIButton) {
        uploadBtnindex = 0
        getProfileImage()
    }
    
    @IBAction func actionSubmitBol(_ sender: UIButton) {
        //        if(self.txtBol.text!.isEmpty || self.storeImage == nil){
        if (self.txtBol.text!.isEmpty || storeImage0 == nil){
            AlertService().showAlert(title: "Alert", message: "Fill all fields. Both BOL number and reciept is required.", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "Fill all fields. Both BOL number and reciept is required.", title: "")
        }else{
            
            //            bolApiCall(params, and: storeImage!)
            
            /* Ashok */
            if storeImage0 == nil{
                
            }else{
                storeImageCount = 1
            }
            
            if storeImage1 == nil{
                
            }else{
                storeImageCount += 1
            }
            
            if storeImage2 == nil{
                
            }else{
                storeImageCount += 1
            }
            
            if storeImage3 == nil{
                
            }else{
                storeImageCount += 1
            }
            
            if storeImage4 == nil{
                
            }else{
                storeImageCount += 1
            }
            
            if storeImage5 == nil{
                
            }else{
                storeImageCount += 1
            }
            
            let params:[String:String] = [DictKeys.loadId : "\(dispatchObject.loadData.load_id)",
                DictKeys.companyId : dispatchObject.loadData.company_id,
                DictKeys.deliveryId : "\(delivery.id)",
                DictKeys.bol : self.txtBol.text!,
                "status": statusParam, "totalcount": String(storeImageCount)]
            print(selectImagePdf)
            bolApiCallNew(params, and: storeImage0, image1: storeImage1, image2: storeImage1, image3: storeImage3, image4: storeImage4, image5: storeImage5, imagePdf: selectImagePdf)
        }
    }
    
    @IBAction func alreadySubmitBtnAction(_ sender: UIButton) {
        
        apiCallPickupDeliveryStatus(params: [DictKeys.id : delivery?.id ?? kIntDefault], isDelivery, delivery, pickup)
    }
    
    
    func callBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func callBackHome() {
//        for controller in self.navigationController?.viewControllers ?? [] {
//            if controller.isKind(of: HomeViewController.self) {
//                self.navigationController?.popToViewController(controller, animated: true)
//            }
//        }
        
        if #available(iOS 13.0, *) {
            let homeViewController = storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
            self.navigationController?.pushViewController(homeViewController!, animated: true)
        } else {
            // Fallback on earlier versions
            let homeViewController = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
            self.navigationController?.pushViewController(homeViewController!, animated: true)
        }
    }
    
    @IBAction func editBtnAction(_ sender: UIButton) {
        
        cropFunction(image: allImageStore)
    }
    
    func cropFunction(image: UIImage){
        let controller = CropViewController()
        controller.delegate = self
        controller.image = image
        
        let navController = UINavigationController(rootViewController: controller)
        present(navController, animated: true, completion: nil)
    }
    
    func actionSheetImage(photo: String, pdf: String){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
            self.showCamera()
        }
        
        let albumAction = UIAlertAction(title: "Photos", style: .default) { action in
            self.openPhotoAlbum()
        }
        
        let pdfAction = UIAlertAction(title: "Files", style: .default) { action in
            self.documentPicker()
        }
        
        if photo == "photo"{
            actionSheet.addAction(cameraAction)
            actionSheet.addAction(albumAction)
        }
        
        if pdf == "pdf"{
            actionSheet.addAction(pdfAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in }
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let scannerViewController = ImageScannerController()
        scannerViewController.imageScannerDelegate = self
        present(scannerViewController, animated: true)
    }
    
    func openPhotoAlbum() {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    func documentPicker(){
        let types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet]
        let importMenu = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
        
        if #available(iOS 11.0, *) {
            importMenu.allowsMultipleSelection = true
        }
        
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        
        present(importMenu, animated: true)
    }
    
    
    func getProfileImage(){
        
        if uploadBtnindex == 0 {
            
            actionSheetImage(photo: "photo", pdf: "pdf")
//            AttachmentHandler.shared.showAttachmentActionSheet(vc: self, libraryModes: [.camera, .photoLibrary, .document])
//            AttachmentHandler.shared.imagePickerBlock = { [weak self] (image, imageName) in
//
//                guard let self = self else {
//                    return
//                }
//                self.selectedImageAndPDf(type: "image", imageData: image.jpegData(compressionQuality: 0.75)!, imageName: imageName)
//            }
//
//            AttachmentHandler.shared.documentPickerBlock = { [weak self] (documentUrl) in
//
//                guard let self = self else {
//                    return
//                }
//
//                if let urlString = documentUrl.absoluteString {
//                    let pdfData = try! Data(contentsOf: urlString.asURL())
//                    self.selectedImageAndPDf(type: "pdf", imageData: pdfData, imageName: documentUrl.lastPathComponent ?? "")
//                }
//            }
        }
        
        if uploadBtnindex == 1 || uploadBtnindex == 2 || uploadBtnindex == 3 || uploadBtnindex == 4 || uploadBtnindex == 5{
            let text = lblNoFileChosen.text
            if text?.contains(".jpeg") ?? false || text?.contains(".jpg") ?? false || text?.contains(".png") ?? false{
                actionSheetImage(photo: "photo", pdf: "")
//                AttachmentHandler.shared.showAttachmentActionSheet(vc: self, libraryModes: [.camera, .photoLibrary])
//                AttachmentHandler.shared.imagePickerBlock = { [weak self] (image, imageName) in
//
//                    guard let self = self else {
//                        return
//                    }
//
//                    self.selectedImageAndPDf(type: "image", imageData: image.jpegData(compressionQuality: 0.75)!, imageName: imageName)
//                }
            }else{
                
                actionSheetImage(photo: "", pdf: "pdf")
//                AttachmentHandler.shared.showAttachmentActionSheet(vc: self, libraryModes: [.document])
//                AttachmentHandler.shared.documentPickerBlock = { [weak self] (documentUrl) in
//
//                    guard let self = self else {
//                        return
//                    }
//
//                    if let urlString = documentUrl.absoluteString {
//                        let pdfData = try! Data(contentsOf: urlString.asURL())
//                        self.selectedImageAndPDf(type: "pdf", imageData: pdfData, imageName: documentUrl.lastPathComponent ?? "")
//                    }
//                }
            }
        }
        
    }
    
    //    func getProfileImage(){
    //
    //        let imagePicker = UIImagePickerController()
    //        imagePicker.delegate = self
    //
    //        let actionSheet = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
    //        //  actionSheet.addAction(.init(title: LocalStrings.UploadFile, style: .default, handler: { (UIAlertAction) in
    //
    //        // }))
    //
    //        if uploadBtnindex == 0 {
    //
    //            actionSheet.addAction(.init(title: LocalStrings.Camera, style: .default, handler: { (UIAlertAction) in
    //                if UIImagePickerController.isSourceTypeAvailable(.camera){
    //                    imagePicker.sourceType = .camera
    //                    self.present(imagePicker, animated: true, completion:  nil)
    //                }else{
    //                    print(PopupMessages.cameraIsNotAvailable)
    //                }
    //            }))
    //            actionSheet.addAction(.init(title: LocalStrings.PhotoLibrary, style: .default, handler: { (UIAlertAction) in
    //                imagePicker.sourceType = .photoLibrary
    //                self.present(imagePicker, animated: true, completion:  nil)
    //            }))
    //
    //            Ashok
    //            actionSheet.addAction(.init(title: LocalStrings.UploadFile, style: .default, handler: { (UIAlertAction) in
    //                let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text", "com.apple.iwork.pages.pages", "public.data", "public.image", "com.adobe.pdf", "public.jpeg", "public.png"], in: .import)
    //
    //                documentPicker.delegate = self
    //                self.present(documentPicker, animated: true, completion: nil)
    //            }))
    //        }
    //
    //        if uploadBtnindex == 1 || uploadBtnindex == 2 || uploadBtnindex == 3{
    //            let text = lblNoFileChosen.text
    //            if text?.contains(".jpeg") ?? false || text?.contains(".jpg") ?? false || text?.contains(".png") ?? false{
    //                actionSheet.addAction(.init(title: LocalStrings.Camera, style: .default, handler: { (UIAlertAction) in
    //                    if UIImagePickerController.isSourceTypeAvailable(.camera){
    //                        imagePicker.sourceType = .camera
    //                        self.present(imagePicker, animated: true, completion:  nil)
    //                    }else{
    //                        print(PopupMessages.cameraIsNotAvailable)
    //                    }
    //                }))
    //                actionSheet.addAction(.init(title: LocalStrings.PhotoLibrary, style: .default, handler: { (UIAlertAction) in
    //                    imagePicker.sourceType = .photoLibrary
    //                    self.present(imagePicker, animated: true, completion:  nil)
    //                }))
    //
    //            }else{
    //                actionSheet.addAction(.init(title: LocalStrings.UploadFile, style: .default, handler: { (UIAlertAction) in
    //                    let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text", "com.apple.iwork.pages.pages", "public.data", "public.image", "com.adobe.pdf", "public.jpeg", "public.png"], in: .import)
    //
    //                    documentPicker.delegate = self
    //                    self.present(documentPicker, animated: true, completion: nil)
    //                }))
    //
    //
    //            }
    //        }
    //
    //        actionSheet.addAction(.init(title: LocalStrings.Cancel, style: .cancel, handler: { (UIAlertAction) in
    //
    //        }))
    //        self.present(actionSheet, animated: true, completion:  nil)
    //    }
    
    //    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    //        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    //        self.storeImage = image
    //        let url = info[UIImagePickerController.InfoKey.imageURL] as! URL
    //        let imageName = url.lastPathComponent
    //
    //        /* Ashok */
    //        if uploadBtnindex == 0{
    //            selectImagePdf = "image"
    //            self.lblNoFileChosen.text = imageName
    //            storeImage0 = image.jpegData(compressionQuality: 0.75)
    //            if chooseFileLbl1.text == "No file chosen" || chooseFileLbl2.text == "No file chosen" || chooseFileLbl3.text == "No file chosen"{
    //
    //            }else{
    //                if lblNoFileChosen.text?.strstr(needle: ".") == self.chooseFileLbl1.text?.strstr(needle: "."){
    //
    //                }else{
    //                    storeImage1 = nil
    //                }
    //                if lblNoFileChosen.text?.strstr(needle: ".") == self.chooseFileLbl2.text?.strstr(needle: "."){
    //
    //                }else{
    //                    storeImage2 = nil
    //                }
    //                if lblNoFileChosen.text?.strstr(needle: ".") == self.chooseFileLbl3.text?.strstr(needle: "."){
    //
    //                }else{
    //                    storeImage3 = nil
    //                }
    //            }
    //
    //        }
    //
    //        if uploadBtnindex == 1{
    //            self.chooseFileLbl1.text = imageName
    //            storeImage1 = image.jpegData(compressionQuality: 0.75)
    //
    //        }
    //
    //        if uploadBtnindex == 2{
    //            self.chooseFileLbl2.text = imageName
    //            storeImage2 = image.jpegData(compressionQuality: 0.75)
    //        }
    //
    //        if uploadBtnindex == 3{
    //            self.chooseFileLbl3.text = imageName
    //            storeImage3 = image.jpegData(compressionQuality: 0.75)
    //        }
    //        picker.dismiss(animated: true, completion: nil)
    //    }
    
    func bolApiCall(_ params: [String : String], and image:UIImage){
         ActivityIndicator.shared().show()
//        self.startActivityWithMessage()
        let imageDict = [DictKeys.bolUpload:image.jpegData(compressionQuality: 0.75)!]
        GCD.async(.Background) {
            RegisterationService.shared().uploadBolWithDelivery(params: params, dict: imageDict) { (message, success, json) in
                GCD.async(.Main) {
                    ActivityIndicator.shared().hide()
//                    self.stopActivity()
                    if(success){
                        AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {
//                        self.showAlertView(message: message, title: "", doneButtonTitle: "OK") { (action) in
                            self.callBackHome()
                        })
                    }else{
                        AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {})
//                        self.showAlertView(message: message, title: "")
                    }
                    
                }
            }
        }
    }
    
    /* Ashok */
    func bolApiCallNew(_ params: [String : String], and image0: Data?, image1: Data?, image2: Data?, image3: Data?, image4: Data?, image5: Data?, imagePdf: String){
        ActivityIndicator.shared().show()
//        self.startActivityWithMessage()
        GCD.async(.Background) {
            RegisterationService.shared().uploadBolWithDeliveryNew(params: params, image0: image0, image1: image1, image2: image2, image3: image3, image4: image4, image5: image5, imagePdf: imagePdf) { (message, success, json) in
                GCD.async(.Main) {
                    ActivityIndicator.shared().hide()
//                    self.stopActivity()
                    if(success){
                        
                        if self.statusParam == "0"{
                            AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {
//                            self.showAlertView(message: message, title: "", doneButtonTitle: "OK") { (action) in
                                if(self.isDelivery){
                                    self.delivery?.status = "1"
                                    self.delivery?.status_message = "Delivery Done"
                                    self.delivery?.shouldShowButton = false
                                }else{
                                    self.pickup?.status = "1"
                                    self.pickup?.status_message = "Pickup Done"
                                    self.pickup?.shouldShowButton = false
                                }
                                self.dispatchObject.checkForPickupsDeliveries()
                                self.navigationController?.popViewController(animated: true)
//                            }
                            })
                        }else{
                            AlertService().showAlert(title: "Alert", message: "Your load is completed", actionButtonTitle: "OK", completion: {
//                            self.showAlertView(message: "Your load is completed", title: "successfully", doneButtonTitle: "OK") { (action) in
                                if(self.isDelivery){
                                    self.delivery?.status = "1"
                                    self.delivery?.status_message = "Delivery Done"
                                    self.delivery?.shouldShowButton = false
                                }else{
                                    self.pickup?.status = "1"
                                    self.pickup?.status_message = "Pickup Done"
                                    self.pickup?.shouldShowButton = false
                                }
                                self.dispatchObject.checkForPickupsDeliveries()
                                self.callBackHome()
                            })
                        }
                    }else{
                        AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {})
//                        self.showAlertView(message: message, title: "")
                    }
                    
                }
            }
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
                    if(isDelivery){
                        delivery?.status = "1"
                        delivery?.status_message = "Delivery Done"
                        delivery?.shouldShowButton = false
                    }else{
                        pickup?.status = "1"
                        pickup?.status_message = "Pickup Done"
                        pickup?.shouldShowButton = false
                    }
                    self.dispatchObject.checkForPickupsDeliveries()
                    AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {
//                    self.showAlertView(message: message, title: "", doneButtonTitle: "OK") { (action) in
                        if self.statusParam == "0"{
                            self.navigationController?.popViewController(animated: true)
                        }else{
                            self.callBackHome()
                        }
                    })
                    
                }
            }
        }
    }
    
    
    func selectedImageAndPDf(type: String, imageData: Data, imageName: String){
        
        /* Ashok */
        if uploadBtnindex == 0{
            selectImagePdf = type
            self.lblNoFileChosen.text = imageName
            storeImage0 = imageData
            if chooseFileLbl1.text == "No file chosen" || chooseFileLbl2.text == "No file chosen" || chooseFileLbl3.text == "No file chosen" || chooseFileLbl4.text == "No file chosen" || chooseFileLbl5.text == "No file chosen"{
                
            }else{
                if lblNoFileChosen.text?.strstr(needle: ".") == self.chooseFileLbl1.text?.strstr(needle: "."){
                    
                }else{
                    storeImage1 = nil
                }
                if lblNoFileChosen.text?.strstr(needle: ".") == self.chooseFileLbl2.text?.strstr(needle: "."){
                    
                }else{
                    storeImage2 = nil
                }
                if lblNoFileChosen.text?.strstr(needle: ".") == self.chooseFileLbl3.text?.strstr(needle: "."){
                    
                }else{
                    storeImage3 = nil
                }
                if lblNoFileChosen.text?.strstr(needle: ".") == self.chooseFileLbl4.text?.strstr(needle: "."){
                    
                }else{
                    storeImage4 = nil
                }
                if lblNoFileChosen.text?.strstr(needle: ".") == self.chooseFileLbl5.text?.strstr(needle: "."){
                    
                }else{
                    storeImage5 = nil
                }
            }
            
        }
        
        if uploadBtnindex == 1{
            self.chooseFileLbl1.text = imageName
            storeImage1 = imageData
            
        }
        
        if uploadBtnindex == 2{
            self.chooseFileLbl2.text = imageName
            storeImage2 = imageData
        }
        
        if uploadBtnindex == 3{
            self.chooseFileLbl3.text = imageName
            storeImage3 = imageData
        }
        
        if uploadBtnindex == 4{
            self.chooseFileLbl4.text = imageName
            storeImage4 = imageData
        }
        
        if uploadBtnindex == 5{
            self.chooseFileLbl5.text = imageName
            storeImage5 = imageData
        }
    }
}

/* Ashok */
//extension UploadBolViewController: UIDocumentPickerDelegate{
//
//    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        //               guard controller.documentPickerMode == .open, let url = urls.first, url.startAccessingSecurityScopedResource() else { return }
//        //               defer {
//        //                   DispatchQueue.main.async {
//        //                       url.stopAccessingSecurityScopedResource()
//        //                   }
//        //                    }
//        //
//        //               guard let image = UIImage(contentsOfFile: url.path) else { return }
//        var data = Data()
//        let url = urls.first
//        url?.startAccessingSecurityScopedResource()
//        if let urlString = url {
//            let pdfData = try! Data(contentsOf: urlString.asURL())
//            data = pdfData
//        }
//        let fileName = url?.lastPathComponent
//
//        /* Ashok */
//        if uploadBtnindex == 0{
//            selectImagePdf = "pdf"
//            self.lblNoFileChosen.text = fileName
//            storeImage0 = data
//            if chooseFileLbl1.text == "No file chosen" || chooseFileLbl2.text == "No file chosen" || chooseFileLbl3.text == "No file chosen"{
//
//            }else{
//                if lblNoFileChosen.text?.strstr(needle: ".") == self.chooseFileLbl1.text?.strstr(needle: "."){
//
//                }else{
//                    storeImage1 = nil
//                }
//                if lblNoFileChosen.text?.strstr(needle: ".") == self.chooseFileLbl2.text?.strstr(needle: "."){
//
//                }else{
//                    storeImage2 = nil
//                }
//                if lblNoFileChosen.text?.strstr(needle: ".") == self.chooseFileLbl3.text?.strstr(needle: "."){
//
//                }else{
//                    storeImage3 = nil
//                }
//            }
//
//        }
//
//        if uploadBtnindex == 1{
//            self.chooseFileLbl1.text = fileName
//            storeImage1 = data
//
//        }
//
//        if uploadBtnindex == 2{
//            self.chooseFileLbl2.text = fileName
//            storeImage2 = data
//        }
//
//        if uploadBtnindex == 3{
//            self.chooseFileLbl3.text = fileName
//            storeImage3 = data
//        }
//        controller.dismiss(animated: true)
//    }
//
//    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
//        controller.dismiss(animated: true)
//    }
//}


extension UploadBolViewController: CropViewControllerDelegate{
    // MARK: - CropView
    func cropViewController(_ controller: CropViewController, didFinishCroppingImage image: UIImage) {
        
        self.selectedImageAndPDf(type: "image", imageData: image.jpegData(compressionQuality: 0.5)!, imageName: "\(Date().timeIntervalSinceReferenceDate)" + ".jpeg")
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func cropViewController(_ controller: CropViewController, didFinishCroppingImage image: UIImage, transform: CGAffineTransform, cropRect: CGRect) {
        allImageStore = image
        self.selectedImageAndPDf(type: "image", imageData: image.jpegData(compressionQuality: 0.5)!, imageName: "\(Date().timeIntervalSinceReferenceDate)" + ".jpeg")
        controller.dismiss(animated: true, completion: nil)
    }
    
    func cropViewControllerDidCancel(_ controller: CropViewController) {
        controller.dismiss(animated: true, completion: nil)
        //updateEditButtonEnabled()
    }
}


extension UploadBolViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    // MARK: - UIImagePickerController delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        
        if let image = info[.originalImage] as? UIImage{
            allImageStore = image
            self.selectedImageAndPDf(type: "image", imageData: image.jpegData(compressionQuality: 0.5)!, imageName: "\(Date().timeIntervalSinceReferenceDate)" + ".jpeg")
            
            dismiss(animated: true) { [unowned self] in
                self.editBtnAction(self.editmgbtn)
            }
        }else{
            dismiss(animated: true, completion: nil)
        }
    }
}

extension UploadBolViewController: ImageScannerControllerDelegate{
    
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        // You are responsible for carefully handling the error
        print(error)
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        
        allImageStore = results.croppedScan.image
        self.selectedImageAndPDf(type: "image", imageData: results.croppedScan.image.jpegData(compressionQuality: 0.5)!, imageName: "\(Date().timeIntervalSinceReferenceDate)" + ".jpeg")
        scanner.dismiss(animated: true)
    }
    
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        // The user tapped 'Cancel' on the scanner
        // You are responsible for dismissing the ImageScannerController
        scanner.dismiss(animated: true)
    }
}

extension UploadBolViewController : UIDocumentPickerDelegate, UIDocumentInteractionControllerDelegate{
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let documentUrl = urls.first else {return}
        let displayDocument = UIDocumentInteractionController(url: documentUrl)
        displayDocument.delegate = self
        displayDocument.presentPreview(animated: true)
        let pdfData = try! Data(contentsOf: documentUrl.absoluteString.asURL())
        self.selectedImageAndPDf(type: "pdf", imageData: pdfData, imageName: documentUrl.lastPathComponent)
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}
