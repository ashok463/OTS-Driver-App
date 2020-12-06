//
//  ViewDetailsViewController.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 19/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

class ViewDetailsViewController: UIViewController {
    
    @IBOutlet weak var lblVendor: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblFuelType: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblFuelGallons: UILabel!
    @IBOutlet weak var lblDEFGallons: UILabel!
    @IBOutlet weak var lblReeferGallons: UILabel!
    @IBOutlet weak var lblOdometer: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblZipcode: UILabel!
    @IBOutlet weak var popupView: UIView!
    
    var tapGesture = UITapGestureRecognizer()
    var expenseModel:ExpenseViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        setupExpenseDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    fileprivate func setupExpenseDetails() {
        expenseModel = Global.shared.expenseViewModel
        lblVendor.text = expenseModel.vendorId
        lblDate.text = expenseModel.date
        lblFuelType.text = expenseModel.type
        lblAmount.text = expenseModel.amount
        lblUnit.text = expenseModel.unitId
        lblDescription.text = expenseModel.description
        lblFuelGallons.text = expenseModel.galoons
        lblDEFGallons.text = expenseModel.defGallons
        lblReeferGallons.text = expenseModel.refGallons
        lblOdometer.text = expenseModel.odometer
        lblCity.text = expenseModel.city
        lblState.text = expenseModel.state
        lblCountry.text = expenseModel.country
        lblZipcode.text = expenseModel.zipcode
    }
    
    
    @IBAction func actionClose(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionSeeReceipt(_ sender: UIButton){
        if expenseModel.uploadReceipt.count > 0 {
            let controller = storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.DisplayImageViewController) as! DisplayImageViewController
            controller.imageURL = expenseModel.uploadReceipt
            self.navigationController?.pushViewController(controller, animated: true)
        }else {
            AlertService().showAlert(title: "Alert", message: "No attachment available", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "No attachment available")
        }
    }
    
    
    
}
