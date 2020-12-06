//
//  DisplayImageViewController.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 03/03/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit
import SDWebImage
import PDFKit
import NVActivityIndicatorView
import SVProgressHUD
import WebKit


class DisplayImageViewController: BaseViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var topBackView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgImageView: UIImageView!
    
    var imageURL:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        self.lblTitle.text = "Attachment"
        if imageURL == "" || imageURL == nil{
            AlertService().showAlert(title: "Alert", message: "No Image Found", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "Error", title: "No Image Found")
        }else{
            if imageURL.contains(".pdf"){
                imgImageView.isHidden = true
                webView.isHidden = false
                loadWebView(imgUrl: imageURL)
            }else{
                imgImageView.isHidden = false
                webView.isHidden = true
                self.setImageWithUrl(imageView: self.imgImageView, url: imageURL)
            }
        }
    }
    
    func loadWebView(imgUrl: String) {
        SVProgressHUD.show()
        let request = URLRequest(url: URL.init(string: imgUrl)!)
        DispatchQueue.main.async {
            self.webView.load(request)
        }
    }
    
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


extension DisplayImageViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
}
