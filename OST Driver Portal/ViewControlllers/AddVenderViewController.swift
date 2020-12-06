//
//  AddVenderViewController.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 24/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit
import DropDown

class AddVenderViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtZipcode: UITextField!
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var btnType: UIButton!
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var btnState: UIButton!
    @IBOutlet weak var btnCountry: UIButton!
    
    //MARK:- Objects and variables
    var type:String!
    var city:String!
    var state:String!
    var zipCode:String!
    var country:String!
    var companyId:String!
    
    let typeDropDown = DropDown()
    let cityDropDown = DropDown()
    let stateDropDown = DropDown()
    let countryDropDown = DropDown()
    let zipCodeDropDown = DropDown()
    
    weak var delegate: VendorsDelegate?
    var statesList = [StateViewModel]()
    let typeList = ["Fuel","Maintainance","Others"]
    let countryList = ["United States", "Canada", "Mexico"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropDown()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if let container = self.mainContainer{
//            container.setTitleAndButton(title: TitleName.AddaVendor, isHideBtnBack: false, isHideBtnHome: false)
//        }
//    }
    
    //MARK:- Custom methods
    func setupDropDown(){
        typeDropDown.anchorView = self.btnType
        typeDropDown.direction = .any
        typeDropDown.dataSource = typeList
        self.typeDropDown.selectionAction = { [weak self] (index, item) in
            self?.type = item
            self?.btnType.setTitle(item, for: .normal)
        }
        
        countryDropDown.anchorView = btnCountry
        countryDropDown.direction = .any
        countryDropDown.dataSource = countryList

        countryDropDown.selectionAction = {[weak self] (index, item) in
            self?.state = nil
            self?.country = item
            self?.lblCountry.text = item
            self?.lblState.text = kBlankString
            let params:ParamsAny = [DictKeys.country:item]
            self?.getStatesList(with: params)
        }
    }
    
    fileprivate func setupStatesDropDown(_ states:[StateViewModel]) {
        stateDropDown.anchorView = btnState
        stateDropDown.direction = .any
        stateDropDown.dataSource = states.map {$0.name}

        stateDropDown.selectionAction = {[weak self] (index, item) in
            self?.city = nil
            self?.state = item
            self?.lblState.text = item
            self?.lblCity.text = kBlankString
            let params:ParamsAny = [DictKeys.state:item]
            self?.getCitiesList(with: params)
        }
    }
    
    fileprivate func setupCitiesDropDown(_ cities:[CityViewModel]) {
        cityDropDown.anchorView = btnCity
        cityDropDown.direction = .any
        cityDropDown.dataSource = cities.map {$0.name}

        cityDropDown.selectionAction = {[weak self] (index, item) in
            self?.city = item
            self?.lblCity.text = item
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Action methods
    @IBAction func actionSelectCountry(_ sender: Any) {
        self.countryDropDown.show()
    }
    
    @IBAction func actionSelectState(_ sender: Any) {
        self.stateDropDown.show()
    }
    
    @IBAction func actionSelectCity(_ sender: Any) {
        self.cityDropDown.show()
    }
    
    @IBAction func actionSave(_ sender: UIButton){
        if txtName.text!.count == 0 {
            AlertService().showAlert(title: "Alert", message: "Name cannot be empty", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "Name cannot be empty")
        }else if txtPhone.text!.count == 0 {
            AlertService().showAlert(title: "Alert", message: "phone cannot be empty", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "phone cannot be empty")
        }else if txtStreet.text!.count == 0 {
            AlertService().showAlert(title: "Alert", message: "Street Name cannot be empty", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "Street Name cannot be empty")
        }else if self.state == nil {
            AlertService().showAlert(title: "Alert", message: "State Name cannot be empty", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "State Name cannot be empty")
        }else if type == nil {
            AlertService().showAlert(title: "Alert", message: "Please select a type first", actionButtonTitle: "OK", completion: {})
//            self.showAlertView(message: "Please select a type first")
        }else {
            let params:ParamsAny = [DictKeys.companyId:companyId!,
                                    DictKeys.name: txtName.text!,
                                    DictKeys.phone:txtPhone.text!,
                                    DictKeys.street:txtStreet.text!,
                                    DictKeys.city:self.lblCity.text!,
                                    DictKeys.state:self.state!,
                                    DictKeys.country: self.country!,
                                    DictKeys.zipCode:txtZipcode.text!,
                                    DictKeys.type:self.type!]
            self.addVendor(params)
        }
    }
    
    fileprivate func addVendor(_ params:ParamsAny) {
        ActivityIndicator.shared().show()
//        self.startActivityWithMessage()
        GCD.async(.Background) {
            ExpenseService.shared().addVendor(params: params) { (message, success) in
                GCD.async(.Main) {
                    ActivityIndicator.shared().hide()
//                    self.stopActivity()
                    if success {
                        AlertService().showAlert(title: "OTS Driver", message: message, actionButtonTitle: "OK", completion: {
//                        self.showAlertView(message: message, title: ALERT_TITLE_APP_NAME, doneButtonTitle: LocalStrings.OK) { (_) in
                            self.delegate?.shouldUpdateExpenseData()
                            self.navigationController?.popViewController(animated: true)
                        })
                    }else {
                        AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {})
//                        self.showAlertView(message: message)
                    }
                }
            }
        }
    }
    
    @IBAction func actionDropDown(_ sender: UIButton){
        self.typeDropDown.show()
    }
    
}

//MARK:- API Calls
extension AddVenderViewController {
    fileprivate func getStatesList(with params:ParamsAny) {
        ActivityIndicator.shared().show()
//        self.startActivityWithMessage()
        GCD.async(.Background) {
            ExpenseService.shared().getStatesList(params: params) { (message, success, states) in
                GCD.async(.Main) {
                    ActivityIndicator.shared().hide()
//                    self.stopActivity()
                    if success {
                        self.setupStatesDropDown(states!)
                    }else {
                        AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {})
//                        self.showAlertView(message: message)
                    }
                }
            }
        }
    }
    
    fileprivate func getCitiesList(with params:ParamsAny) {
        ActivityIndicator.shared().show()
//        self.startActivityWithMessage()
        GCD.async(.Background) {
            ExpenseService.shared().getCitiesList(params: params) { (message, success, cities) in
                GCD.async(.Main) {
                    ActivityIndicator.shared().hide()
//                    self.stopActivity()
                    if success {
                        self.setupCitiesDropDown(cities!)
                    }else {
                        AlertService().showAlert(title: "Alert", message: message, actionButtonTitle: "OK", completion: {})
//                        self.showAlertView(message: message)
                    }
                }
            }
        }
    }
}
