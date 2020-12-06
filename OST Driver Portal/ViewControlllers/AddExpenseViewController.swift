//
//  AddExpenseViewController.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 19/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit
import DropDown
import CoreLocation
import WeScan
import MobileCoreServices

class AddExpenseViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblZipCode: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblVendor: UILabel!
    @IBOutlet weak var btnCategoryDropDown: UIButton!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtEnterAmount: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var btnSelectUnitDropDown: UIButton!
    @IBOutlet weak var txtFuelGallons: UITextField!
    @IBOutlet weak var txtDefGallons: UITextField!
    @IBOutlet weak var txtReeferGallons: UITextField!
    @IBOutlet weak var txtOdometer: UITextField!
    @IBOutlet weak var btnselectVendorDropDown: UIButton!
    @IBOutlet weak var lblNoFileChoose: UILabel!
    @IBOutlet weak var fuelStackView: UIStackView!
    @IBOutlet weak var descriptionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var fuelStackHeight: NSLayoutConstraint!
    
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
    
    //MARK:- Objects and variables
    
    var isEditExpense = false
    var isLocationEnabled = false
    var selectedReceiptImage: UIImage!
    var expenseData:AddExpenseViewModel!
    var editExpenseData:EditExpenseDataViewModel!
    var locationManager = CLLocationManager()
    var imagesPicker = UIImagePickerController()
    var locationCoordinates: CLLocationCoordinate2D!
    
    var unit:UnitViewModel!
    var expenseId:Int!
    var category:String!
    var vendor:VendorViewModel!
    var expenseModel:ExpenseViewModel!
    
    let unitDropDown = DropDown()
    let categoryDropDown = DropDown()
    
    var  uploadBtnindex = 0
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
    
    //MARK:- Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesPicker.delegate = self
        
        topConstrainsuploadImageBackgroundView1.constant = 0
        topConstrainsuploadImageBackgroundView2.constant = 0
        topConstrainsuploadImageBackgroundView3.constant = 0
        topConstrainsuploadImageBackgroundView4.constant = 0
        topConstrainsuploadImageBackgroundView5.constant = 0
        
        topConstrainsuploadImageBackgroundView1.constant = 0
        topConstrainsuploadImageBackgroundView2.constant = 0
        topConstrainsuploadImageBackgroundView3.constant = 0
        topConstrainsuploadImageBackgroundView4.constant = 0
        topConstrainsuploadImageBackgroundView5.constant = 0
        
        if isEditExpense {
            let params:ParamsAny = [DictKeys.expenseId:expenseId!]
            self.getEditExpenseData(params)
            setupLocationManager()
        }else {
            self.setupDate()
        }
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        mainContainer?.delegate = self
//        if isEditExpense {
//            mainContainer?.setTitleAndButton(title: TitleName.editExpense, isHideBtnBack: false, isHideBtnHome: false)
//        }else {
//            mainContainer?.setTitleAndButton(title: TitleName.AddAnExpense, isHideBtnBack: false, isHideBtnHome: false)
//        }
//        
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isEditExpense {
            self.setupLocationManager()
        }
    }
    
    //MARK:- Custom Methods
    fileprivate func setupDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateString = formatter.string(from: date)
        self.txtDate.text = dateString
    }
    
    fileprivate func loadExpenseDetails(_ expenseDetails:EditExpenseDataViewModel) {
        self.editExpenseData = expenseDetails
        self.vendor = (expenseDetails.vendors.filter {$0.id == Int(expenseDetails.expenseData.vendorId)!}).first
        self.unit = (expenseDetails.units.filter {$0.id == Int(expenseDetails.expenseData.unitId)!}).first
        
        self.lblVendor.text = self.vendor.name
        self.category = expenseDetails.expenseData.type
        self.txtDate.text = expenseDetails.expenseData.date
        self.lblCity.text = expenseDetails.expenseData.city
        self.lblState.text = expenseDetails.expenseData.state
        self.lblCategory.text = expenseDetails.expenseData.type
        self.lblZipCode.text = expenseDetails.expenseData.zipcode
        self.txtOdometer.text = expenseDetails.expenseData.odometer
        self.txtEnterAmount.text = expenseDetails.expenseData.amount
        self.lblUnit.text = "\(self.unit.number) (\(self.unit.type))"
        self.txtFuelGallons.text = expenseDetails.expenseData.galoons
        self.txtDefGallons.text = expenseDetails.expenseData.defGallons
        self.txtDescription.text = expenseDetails.expenseData.description
        self.txtReeferGallons.text = expenseDetails.expenseData.refGallons
        
        if expenseDetails.expenseData.type == "Fuel" {
            self.fuelStackView.isHidden = false
            self.fuelStackHeight.constant = 190
            self.descriptionViewHeight.constant = 0
        }else {
            self.fuelStackView.isHidden = true
            self.fuelStackHeight.constant = 0
            self.descriptionViewHeight.constant = 80
        }
        self.view.layoutIfNeeded()
        self.setupDropDowns()
    }
    
    fileprivate func setupLocationManager() {
        self.locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            isLocationEnabled = true
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }else if(CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted){
            self.showLocationPermissionPopup()
        }else {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        
//        if CLLocationManager.locationServicesEnabled() {
//            switch CLLocationManager.authorizationStatus() {
//                case .notDetermined, .restricted, .denied:
//                    print("No access")
//                    isLocationEnabled = false
//                self.showLocationPermissionPopup()
//                case .authorizedAlways, .authorizedWhenInUse:
//                    print("Access")
//                isLocationEnabled = true
//                locationManager.startUpdatingLocation()
//                @unknown default:
//                break
//            }
//            } else {
//                print("Location services are not enabled")
//            isLocationEnabled = false
//            self.showLocationPermissionPopup()
//        }
    }
    
    fileprivate func setupDropDowns() {
        if let address = self.expenseData?.addressComponents {
            self.lblCity.text = address.city
            self.lblZipCode.text = address.postalCode
            self.lblState.text = address.stateLongname
        }
        
        unitDropDown.anchorView = btnSelectUnitDropDown
        unitDropDown.direction = .any
        if isEditExpense {
            unitDropDown.dataSource = editExpenseData.units.map({"\($0.number) (\($0.type))"})
        }else {
            unitDropDown.dataSource = expenseData.units.map({"\($0.number) (\($0.type))"})
        }
        
        unitDropDown.selectionAction = {[weak self] (index, item) in
            if self?.isEditExpense ?? false {
                self?.unit = self?.editExpenseData.units[index]
            }else {
                self?.unit = self?.expenseData.units[index]
            }
            self?.lblUnit.text = item
        }
        
        categoryDropDown.anchorView = btnCategoryDropDown
        categoryDropDown.direction = .any
        if isEditExpense {
            categoryDropDown.dataSource = editExpenseData.categories.map({$0.name})
        }else {
            categoryDropDown.dataSource = expenseData.categories.map({$0.name})
        }
        
        categoryDropDown.selectionAction = {[weak self] (index, item) in
            if item == "Fuel" {
                self?.txtDescription.text = kBlankString
                self?.fuelStackView.isHidden = false
                self?.fuelStackHeight.constant = 190
                self?.descriptionViewHeight.constant = 0
            }else {
                self?.txtFuelGallons.text = kBlankString
                self?.txtDefGallons.text = kBlankString
                self?.txtReeferGallons.text = kBlankString
                self?.fuelStackView.isHidden = true
                self?.fuelStackHeight.constant = 0
                self?.descriptionViewHeight.constant = 80
            }
            self?.view.layoutIfNeeded()
            self?.category = item
            self?.lblCategory.text = item
        }
    }
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- ACTION METHODS
    @IBAction func actionCategoryDropDown(_ sender: UIButton) {
        self.categoryDropDown.show()
    }
    
    @IBAction func actionSelectUnitDropDown(_ sender: UIButton) {
        self.unitDropDown.show()
    }
    
    @IBAction func actionSelectVendorDropDown(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: StoryboardNames.Popup, bundle: nil)
        let venderVC = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.SearchVendorViewController) as! SearchVendorViewController
        venderVC.delegate = self
        if isEditExpense {
            venderVC.vendorList = editExpenseData.vendors
            
        }else {
            venderVC.vendorList = expenseData?.vendors ?? [VendorViewModel]()
        }
        venderVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController?.present(venderVC, animated: true, completion: nil)
    }
    
    @IBAction func actionChooseFile(_ sender: UIButton) {
//        let alertController = UIAlertController(title: ALERT_TITLE_APP_NAME, message: nil, preferredStyle: .actionSheet)
//        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
//            self.imagesPicker.sourceType = .camera
//            self.present(self.imagesPicker, animated: true, completion: nil)
//        }
//
//        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (_) in
//            self.imagesPicker.sourceType = .photoLibrary
//            self.present(self.imagesPicker, animated: true, completion: nil)
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertController.addAction(cameraAction)
//        alertController.addAction(galleryAction)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
        
        uploadBtnindex = 0
        getProfileImage()
    }
    
    @IBAction func actionAdd(_ sender: UIButton) {
        if(!self.isLocationEnabled){
            self.showLocationPermissionPopup()
        }else if txtDate.text!.count == 0 {
            AlertService().showAlert(title: "Alert", message: "Please enter date", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "Please enter date")
        }else if txtEnterAmount.text!.count == 0 {
            AlertService().showAlert(title: "Alert", message: "Please enter amount", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "Please enter amount")
        }else if txtFuelGallons.text!.count == 0 && lblCategory.text == "Fuel"{
            AlertService().showAlert(title: "Alert", message: "Please enter number of gallons used", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "Please enter number of gallons used")
        }else if txtOdometer.text!.count == 0 {
            AlertService().showAlert(title: "Alert", message: "Enter odometer value first", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "Enter odometer value first")
        }else if self.category == nil {
            AlertService().showAlert(title: "Alert", message: "Select category first", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "Select category first")
        }else if self.vendor == nil {
            AlertService().showAlert(title: "Alert", message: "Select Vendor first", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "Select Vendor first")
        }else if self.lblState.text!.count == 0 {
            AlertService().showAlert(title: "Alert", message: "Select state first", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "Select state first")
        }else if self.lblCity.text!.count == 0 {
            AlertService().showAlert(title: "Alert", message: "Select City first", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "Select City first")
        }else if self.storeImage0 == nil && !isEditExpense {
            AlertService().showAlert(title: "Alert", message: "Select image first", actionButtonTitle: "OK", completion: {})
//        else if self.selectedReceiptImage == nil && !isEditExpense {
//            self.showAlertView(message: "Select image first")
        }else {
            if isEditExpense {
                
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
                
                let params:ParamsString = [DictKeys.expenseId:"\(self.editExpenseData.expenseData.id)",
                DictKeys.vendorId:"\(self.vendor.id)",
                DictKeys.companyId:self.editExpenseData.expenseData.companyId,
                DictKeys.date:self.txtDate.text ?? "",
                DictKeys.type:self.category ?? "",
                DictKeys.description:self.txtDescription.text!,
                DictKeys.unitId:self.editExpenseData.expenseData.unitId,
                DictKeys.amount: self.txtEnterAmount.text ?? "",
                DictKeys.galoons:self.txtFuelGallons.text ?? "",
                DictKeys.defGallons:self.txtDefGallons.text ?? "",
                DictKeys.refGallons:self.txtReeferGallons.text ?? "",
                DictKeys.odometer:self.txtOdometer.text ?? "",
                "totalcount": String(storeImageCount)]
               print("params add: \(params)")
                self.updateExpense(with: params)
            }else {
                
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
                let address = self.expenseData.addressComponents
                let params:ParamsString = [DictKeys.vendorId:"\(self.vendor.id)",
                    DictKeys.loadId:self.expenseData.loadId,
                    DictKeys.companyId:self.expenseData.companyId,
                    DictKeys.date:self.txtDate.text!,
                    DictKeys.type:self.category!,
                    DictKeys.description:self.txtDescription.text ?? "",
                    DictKeys.unitId:self.expenseData.unitId,
                    DictKeys.amount: self.txtEnterAmount.text ?? "",
                    DictKeys.galoons:self.txtFuelGallons.text ?? "",
                    DictKeys.defGallons:self.txtDefGallons.text ?? "",
                    DictKeys.refGallons:self.txtReeferGallons.text ?? "",
                    DictKeys.odometer:self.txtOdometer.text ?? "",
                    DictKeys._country: address.countryLongname,
                    DictKeys.countryShort:address.countryShortname,
                    DictKeys.state:address.stateLongname,
                    DictKeys.stateShort: address.stateShortname,
                    DictKeys.city: address.city,
                    DictKeys.zipCode:address.postalCode,
                    DictKeys.lat:"\(locationCoordinates.latitude)",
                    DictKeys.lng:"\(locationCoordinates.longitude)",
                    "totalcount": String(storeImageCount)]
                print("params add: \(params)")
                //self.addExpense(params, image: self.selectedReceiptImage)
                self.addExpense(params)
            }
        }
        
    }
    
    @IBAction func actionAddVendor(_ sender: UIButton){
        let vendorVC = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.AddVenderViewController) as! AddVenderViewController
        vendorVC.delegate = self
        if isEditExpense {
            vendorVC.companyId = self.editExpenseData.expenseData.companyId
        }else {
            vendorVC.companyId = self.expenseData.companyId
        }
        self.navigationController?.pushViewController(vendorVC, animated: true)
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
//
//                self.selectedReceiptImage = image
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
            let text = lblNoFileChoose.text
            if text?.contains(".jpeg") ?? false || text?.contains(".jpg") ?? false || text?.contains(".png") ?? false{
                
                actionSheetImage(photo: "photo", pdf: "")
            }else{
                
                actionSheetImage(photo: "", pdf: "pdf")
            }
        }
        
    }
    
    
    /* Ashok */
    @IBAction func addMoreImagesBtnAction(_ sender: UIButton) {
        
        if lblNoFileChoose.text != "No file chosen"{
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
            if lblNoFileChoose.text != "No file chosen"{
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
        
        
        if lblNoFileChoose.text != "No file chosen" && chooseFileLbl1.text != "No file chosen" && chooseFileLbl2.text != "No file chosen" && chooseFileLbl3.text != "No file chosen" && chooseFileLbl4.text != "No file chosen" && chooseFileLbl5.text != "No file chosen" {
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
    
        func selectedImageAndPDf(type: String, imageData: Data, imageName: String){
            
            /* Ashok */
            if uploadBtnindex == 0{
                selectImagePdf = type
                self.lblNoFileChoose.text = imageName
                storeImage0 = imageData
                if chooseFileLbl1.text == "No file chosen" || chooseFileLbl2.text == "No file chosen" || chooseFileLbl3.text == "No file chosen" || chooseFileLbl4.text == "No file chosen" || chooseFileLbl5.text == "No file chosen"{
                    
                }else{
                    if lblNoFileChoose.text?.strstr(needle: ".") == self.chooseFileLbl1.text?.strstr(needle: "."){
                        
                    }else{
                        storeImage1 = nil
                    }
                    if lblNoFileChoose.text?.strstr(needle: ".") == self.chooseFileLbl2.text?.strstr(needle: "."){
                        
                    }else{
                        storeImage2 = nil
                    }
                    if lblNoFileChoose.text?.strstr(needle: ".") == self.chooseFileLbl3.text?.strstr(needle: "."){
                        
                    }else{
                        storeImage3 = nil
                    }
                    if lblNoFileChoose.text?.strstr(needle: ".") == self.chooseFileLbl4.text?.strstr(needle: "."){
                        
                    }else{
                        storeImage4 = nil
                    }
                    if lblNoFileChoose.text?.strstr(needle: ".") == self.chooseFileLbl5.text?.strstr(needle: "."){
                        
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

//MARK:- Topbar delegate
extension AddExpenseViewController: MainContainerViewControllerDelegate , VendorsDelegate {
    func shouldUpdateExpenseData() {
        if locationCoordinates != nil {
            let params:ParamsAny = [DictKeys.driver_id:Global.shared.user?.id ?? kIntDefault,
                                    DictKeys.lat:locationCoordinates.latitude,
                                    DictKeys.lng:locationCoordinates.longitude]
            self.getAddExpenseDetails(params)
        }
    }
    
    func didSelect(vendor: VendorViewModel) {
        self.vendor = vendor
        self.lblVendor.text = vendor.name
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
}

//MARK:- Location manager delegate
extension AddExpenseViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted || status == .notDetermined {
            self.isLocationEnabled = false
            self.showLocationPermissionPopup()
        }else{
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            self.isLocationEnabled = true
//            if locationCoordinates == nil {
                locationCoordinates = location.coordinate
                let params:ParamsAny = [DictKeys.driver_id:Global.shared.user?.id ?? kIntDefault,
                                        DictKeys.lat:location.coordinate.latitude,
                                        DictKeys.lng:location.coordinate.longitude]
                self.getAddExpenseDetails(params)
            
            shouldUpdateExpenseData()
//            }
        }
    }
    func showLocationPermissionPopup() {
        let alert = UIAlertController(title: ServiceMessage.LocationTitle, message: ServiceMessage.LocationMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ServiceMessage.Settings, style: .default, handler: { (action) in
           
            self.openSettings()
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func openSettings()  {
        let settingUrl = URL(string: UIApplication.openSettingsURLString)!
        if let _ = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(settingUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                } else {
                    UIApplication.shared.openURL(settingUrl)
                }
            }
        }
    }
}

//MARK:- Image picker delegate
//extension AddExpenseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let image = info[.originalImage] as! UIImage
//        self.selectedReceiptImage = image
//        if let url = info[.imageURL] as? URL {
//            let imageNmae = url.lastPathComponent
//            self.lblNoFileChoose.text = imageNmae
//        }else {
//            self.lblNoFileChoose.text = "Image from camera"
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
//}

//MARK:- API Calls
extension AddExpenseViewController {
    fileprivate func addExpense(_ params:ParamsString) {
//        let dict:[String:Data] = [DictKeys.uploadReceipt:image.jpegData(compressionQuality: 0.75)!]
        print(params)
        ActivityIndicator.shared().show()
//        self.startActivityWithMessage()
        GCD.async(.Background) {
            ExpenseService.shared().addExpenes(image0: self.storeImage0, image1: self.storeImage1, image2: self.storeImage2, image3: self.storeImage3, image4: self.storeImage4, image5: self.storeImage5, imagePdf: self.selectImagePdf, params: params, completion: { (message, success) in
                
                GCD.async(.Main) {
                    ActivityIndicator.shared().hide()
//                    self.stopActivity()
                    if success {
                        AlertService().showAlert(title: ALERT_TITLE_APP_NAME, message: message, actionButtonTitle: "OK", completion: {
//                        self.showAlertView(message: message, title: ALERT_TITLE_APP_NAME, doneButtonTitle: LocalStrings.OK) { (_) in
                            self.navigationController?.popViewController(animated: true)
                        })
                    }else {
                        AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {})
//                        self.showAlertView(message: message)
                    }
                }
            })
        }
    }
    
    fileprivate func updateExpense(with params:ParamsString) {
        var dict = [String:Data]()
//        if let image = self.selectedReceiptImage {
//            dict[DictKeys.uploadReceipt] = image.jpegData(compressionQuality: 0.75)
//        }
        ActivityIndicator.shared().show()
//        self.startActivityWithMessage()
        GCD.async(.Background) {
            ExpenseService.shared().saveEditedExpene(imageDict: dict, image0: self.storeImage0, image1: self.storeImage1, image2: self.storeImage2, image3: self.storeImage3, image4: self.storeImage4, image5: self.storeImage5, imagePdf: self.selectImagePdf, params: params, completion: { (message, success) in

                GCD.async(.Main) {
                    ActivityIndicator.shared().hide()
//                    self.stopActivity()
                    if success {
                        AlertService().showAlert(title: ALERT_TITLE_APP_NAME, message: message, actionButtonTitle: "OK", completion: {
//                        self.showAlertView(message: message, title: ALERT_TITLE_APP_NAME, doneButtonTitle: LocalStrings.OK) { (_) in
                            self.navigationController?.popViewController(animated: true)
                        })
                    }else {
                        AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {})
//                        self.showAlertView(message: message)
                    }
                }
            })
        }
    }
    
    fileprivate func getAddExpenseDetails(_ params:ParamsAny) {
        ActivityIndicator.shared().show()
//        self.startActivityWithMessage()
        GCD.async(.Background) {
            ExpenseService.shared().getExpenseData(params: params) { (message, success, expenseData) in
                GCD.async(.Main) {
                    ActivityIndicator.shared().hide()
//                    self.stopActivity()
                    if success {
                        self.expenseData = expenseData
                        self.setupDropDowns()
                    }else {
                        AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {})
//                        self.showAlertView(message: message)
                    }
                }
            }
        }
    }
    
    fileprivate func getEditExpenseData(_ params:ParamsAny) {
        ActivityIndicator.shared().show()
//        self.startActivityWithMessage()
        GCD.async(.Background) {
            ExpenseService.shared().getEditExpenseData(params: params) { (message, success, expenseModel) in
                GCD.async(.Main) {
                    ActivityIndicator.shared().hide()
//                    self.stopActivity()
                    if success {
                        self.loadExpenseDetails(expenseModel!)
                    }else {
                        AlertService().showAlert(title: ALERT_TITLE_APP_NAME, message: message, actionButtonTitle: "OK", completion:{
//                        self.showAlertView(message: message, title: ALERT_TITLE_APP_NAME, doneButtonTitle: LocalStrings.OK) { (_) in
                            self.navigationController?.popViewController(animated: true)
                        })
                    }
                }
            }
        }
    }
    
}


extension AddExpenseViewController: CropViewControllerDelegate{
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


extension AddExpenseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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

extension AddExpenseViewController: ImageScannerControllerDelegate{
    
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

extension AddExpenseViewController : UIDocumentPickerDelegate, UIDocumentInteractionControllerDelegate{
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
