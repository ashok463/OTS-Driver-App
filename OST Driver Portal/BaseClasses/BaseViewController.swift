//
//  BaseViewController.swift
//  AlKadi
//
//  Created by Khurram Bilal Nawaz on 22/07/2016.
//  Copyright © 2016 Khurram Bilal Nawaz. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SVProgressHUD
import SDWebImagePDFCoder
import NVActivityIndicatorView

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    var snapshot: UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
    
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}


//extension UIViewController{
//
//    var mainContainer : MainContainerViewController? {
//
//        get{
//            var foundController: MainContainerViewController? = nil
//            var currentViewController : UIViewController? = self
//
//            if(self.isKind(of: MainContainerViewController.self)){
//                foundController = (self as! MainContainerViewController)
//            }else{
//                while true{
//                    if let parent = currentViewController?.parent {
//                        if parent.isKind(of: MainContainerViewController.self){
//                            foundController = (parent as! MainContainerViewController)
//                            break
//                        }else if parent.isKind(of: BaseNavigationController.self){
//                            let navController = parent as! BaseNavigationController
//                            if let parentController = navController.view.superview?.parentViewController{
//                                if parentController.isKind(of: MainContainerViewController.self){
//                                    foundController = (parentController as! MainContainerViewController)
//                                    break
//                                }
//                            }
//                        }
//
//                    }
//                    else {
//                        break
//                    }
//                    currentViewController = currentViewController?.parent
//                }
//            }
//
//            return foundController
//        }
//    }
//
//}


public class BaseViewController : UIViewController/*,SWRevealViewControllerDelegate*/,UIGestureRecognizerDelegate {
    
   // var disableMenuGesture: Bool = false
    var objAlertVC:BaseViewController?
    var datePickerView: UIDatePicker = UIDatePicker()
    
    lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.tintColor = .white
        view.addTarget(self, action: #selector(handleRefreshController), for: .valueChanged)
        return view
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
       // self.view.changeRTL()
        
    }
    
    @objc func handleRefreshController(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }
    
    func backButtonAction() {
        if navigationController != nil {
            navigationController?.popViewController(animated: true)
        }else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func addTapGesture()  {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    
    
//    func addSideMenu(button:UIButton)  {
//        if revealViewController() != nil {
//            revealViewController().panGestureRecognizer()
//            revealViewController().tapGestureRecognizer()
//
//            revealViewController().rearViewRevealWidth = ScreenSize.SCREEN_WIDTH - 80
//
//            revealViewController().delegate = self
//            if UserDefaultsManager.shared.currentLocale != "en" {
//                button.addTarget(revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: .touchUpInside)
//            }else {
//                button.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
//            }
//
//        }
//    }
//    public func revealControllerPanGestureShouldBegin(_ revealController: SWRevealViewController!) -> Bool {
//        return false
//    }
    
    func languageUpdated(){
        
    }
    
    func actionNextOnContainer(){
        
    }
    
    func actionPreviousOnContainer(){
        
    }
    
    func actionSubmitOnContainer(){
        
    }
    
    func actionCloseOnContainer(){
        
    }
    
    func addShadowOnView(view:UIView,color:UIColor,radius:Int,opacity:Float? = 1) {
        //view.center = self.view.center
        view.layer.shadowOpacity = opacity!
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = CGFloat(radius)
        //self.view.addSubview(view)
    }
    func setBorderColor(view:UIView,color:UIColor? = .white, width:CGFloat? = 1) {
        view.layer.borderWidth = width!
        view.layer.borderColor = color!.cgColor
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = EMAIL_REGULAR_EXPRESSION
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr.trimmingCharacters(in: .whitespaces))
    }
    
    
    
//    func stopActivity (containerView: UIView? = nil) {
//        if let v = containerView{
//            MBProgressHUD.hide(for: v, animated: true)
//        }else{
//            MBProgressHUD.hide(for: self.view, animated: true)
//        }
//    }
    func stopActivity (containerView: UIView? = nil) {
        SVProgressHUD.dismiss()
        self.view.isUserInteractionEnabled = true
//        MKProgress.hide()
    }
    
//    func startActivityWithMessage (msg:String = "Please wait", detailMsg: String = "") {
//        self.hud = MBProgressHUD.showAdded(to: self.view, animated:true)
//        hud.color = UIColor.gray
//        hud.activityIndicatorColor = UIColor.white
//        self.hud.labelText = msg
//        self.hud.detailsLabelText = detailMsg
//    }
    func startActivityWithMessage() {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
//        MKProgress.show()
    }

 
//    func startActivityInView(view: UIView) {
//        self.hud = MBProgressHUD.showAdded(to: view, animated:true)
//        self.hud.layoutSubviews()
//    }
//    
 
    //Mark:-designButton
    func designButton(button: UIButton, borderWidth: CGFloat, cornerRadius: CGFloat, borderColor: UIColor?){
        button.layer.cornerRadius = cornerRadius
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = borderColor?.cgColor
    }
    //Mark:-designTextFiled
    func designTextField(textField: UITextField, borderWidth: CGFloat, cornerRadius: CGFloat, borderColor: UIColor?){
        textField.layer.cornerRadius = cornerRadius
        textField.layer.borderWidth = borderWidth
        textField.layer.borderColor = borderColor?.cgColor
    }
    //Mark:-designTextView
    func designTextView(textview: UITextView, borderWidth: CGFloat, cornerRadius: CGFloat, borderColor: UIColor?){
        textview.layer.cornerRadius = cornerRadius
        textview.layer.borderWidth = borderWidth
        textview.layer.borderColor = borderColor?.cgColor
    }
    
    
    //Mark:-SetImageWithUrl
    func setImageWithUrl(imageView:UIImageView,url:String, placeholder:String? = ""){
        let finalUrl = url.replacingOccurrences(of: " ", with: "%20")
        if let imageurl =  NSURL.init(string: finalUrl){
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
//            imageView.setIndicatorStyle(UIActivityIndicatorView.Style.gray)
//            imageView.setShowActivityIndicator(true)
//            print(imageurl)
            imageView.sd_setImage(with: imageurl as URL?, placeholderImage: UIImage(named:placeholder!))
        }
    }
    
    //Mark:-SetPdfImageWithUrl
    func setPdfImageWithUrl(imageView:UIImageView,url:String, placeholder:String? = ""){
        let finalUrl = url.replacingOccurrences(of: " ", with: "%20")
        if let imageurl =  NSURL.init(string: finalUrl){
            
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
//            setIndicatorStyle(UIActivityIndicatorView.Style.gray)
//            imageView.setShowActivityIndicator(true)
//            print(imageurl)
            let PDFCoder = SDImagePDFCoder.shared
            SDImageCodersManager.shared.addCoder(PDFCoder)
            imageView.sd_setImage(with: imageurl as URL?, placeholderImage: UIImage(named:placeholder!))
        }
    }
    
    func setPlaceholderTextColor(textfield:UITextField,text:String) {
        
        textfield.attributedPlaceholder = NSAttributedString(string: text,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.groupTableViewBackground])
        

    }
    func setPlaceholderBlackColor(textfield:UITextField){
        
        textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder!,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
      
    }
    
    
    func setBorderColor(_ view:UIView,red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat, width: CGFloat? = 1) {
        
        view.layer.borderWidth = width!
        view.layer.borderColor = UIColor(red: red/255, green: green/255, blue: blue/255, alpha:alpha).cgColor
    }

    //MARK:-setToolbarOnPickerView
    func addToolBarToPickerView(textField:UITextField)
    {
        var buttonDone = UIBarButtonItem()
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.sizeToFit()
        let buttonflexible = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        //buttonDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target:self, action:#selector(BaseViewController.doneClicked(_:)))
        
        
        let button =  UIButton(type: .custom)
        button.addTarget(self, action: #selector(BaseViewController.doneClicked(_:)), for: .touchUpInside)
        //button.frame = CGRectMake(0, 0, 53, 31)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
      //  button.setTitleColor(UIColor(netHex: 0xAE2540), for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        button.contentMode = UIView.ContentMode.right
        button.frame = CGRect(x:0, y:0, width:60, height:40)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        
        buttonDone = UIBarButtonItem(customView: button)
        
        
        toolbar.setItems(Array.init(arrayLiteral: buttonflexible,buttonDone), animated: true)
        textField.inputAccessoryView = toolbar
        
    }
    func addToolBarToPickerViewOnTextview(textview:UITextView)
    {
        var buttonDone = UIBarButtonItem()
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.sizeToFit()
        let buttonflexible = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        //buttonDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target:self, action:#selector(BaseViewController.doneClicked(_:)))
        //buttonDone.title = "ye bat"
        
        let button =  UIButton(type: .custom)
        button.addTarget(self, action: #selector(BaseViewController.doneClicked(_:)), for: .touchUpInside)
        //button.frame = CGRectMake(0, 0, 53, 31)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        //button.setTitleColor(UIColor(netHex: 0xAE2540), for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        button.contentMode = UIView.ContentMode.right
        button.frame = CGRect(x:0, y:0, width:60, height:40)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        
        buttonDone = UIBarButtonItem(customView: button)
        toolbar.setItems(Array.init(arrayLiteral: buttonflexible,buttonDone), animated: true)
        textview.inputAccessoryView = toolbar
        
    }
    override public func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing,animated:animated)
        if (self.isEditing) {
            self.editButtonItem.title = "Editing"
        }
        else {
            self.editButtonItem.title = "Not Editing"
        }
    }
    
//    public func revealControllerPanGestureShouldBegin(_ revealController: SWRevealViewController!) -> Bool {
//        if Global.shared.disableMenuGesture! {
//            return false
//        }
//        return true
//    }
    @IBAction func doneClicked(_ sender:AnyObject)
    {
        self.hideKeyboard()
    }
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func showAlertView(message:String) {
        showAlertView(message: message, title: ALERT_TITLE_APP_NAME)
    }
    
    func showAlertView(message:String, title:String, doneButtonTitle:String, doneButtonCompletion: ((UIAlertAction) -> Void)?) {
        showAlertView(message: message, title: title, doneButtonTitle: doneButtonTitle, doneButtonCompletion: doneButtonCompletion, cancelButtonTitle: nil, cancelButtonCompletion: nil)
    }

    func showAlertView(message:String, title:String, doneButtonTitle:String = "OK", doneButtonCompletion: ((UIAlertAction) -> Void)? = nil, cancelButtonTitle:String? = nil, cancelButtonCompletion:((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: doneButtonTitle, style: .default, handler: doneButtonCompletion)
        if let cancelTitle = cancelButtonTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelButtonCompletion)
            alertController.addAction(cancelAction)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func closeAlertMessage() {
        
    }
    func checkInternetConnection() -> Bool {
        if(BReachability.isConnectedToNetwork()){
            return true
        }else{
            self.showAlertView(message:ERROR_NO_NETWORK, title: ALERT_TITLE_APP_NAME)
            return false
        }
    }
    
    
    // Resend Message Popup Delegate
    func actionCallBackResend() {
        
    }
    // Get Profile Data and navigate to Profile Detail Screen
  }
//MARK:- CreateAlertViewMessgaePopup
//extension BaseViewController:AlertViewMessgaePopupDelegate{
//    func createAlertViewMessagePopup(message:String)
//    {
//        self.alertView = CustomIOSAlertView()
//        self.alertView?.buttonTitles = nil
//        self.alertView?.useMotionEffects = true
//        var demoView:UIView!
//        demoView = UIView()
//
//        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardName.Popup, bundle: nil)
//
//        if let vc = storyBoard.instantiateViewController(withIdentifier: "messagePOpupVC" as String)as? AlertViewMessgaePopupViewController
//        {
//            vc.delegate = self
//            self.objAlertVC = vc
//            vc.message = message
//            demoView.frame = CGRect(x:0, y:0, width:300, height:70)
//            vc.view.frame = CGRect(x:0, y:0, width:300, height:70)
//
//            demoView.addSubview(vc.view)
//
//            self.alertView?.containerView = demoView
//        }
//
//    }
//    @objc func callBackCloseAlertMessagePopup(){
//        self.alertView?.close()
//    }
//
//
//}
