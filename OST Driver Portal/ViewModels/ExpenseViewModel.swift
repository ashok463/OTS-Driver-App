//
//  ExpenseViewModel.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 29/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class ExpenseViewModel {
    
    //MARK:- data members
    let id: Int
    let companyId: String
    let loadId: String
    let vendorId: String
    let expenseType: String
    let type: String
    let date: String
    let amount: String
    let description: String
    let unitId: String
    let galoons: String
    let refGallons: String
    let defGallons: String
    let odometer: String
    let country: String
    let state: String
    let city: String
    let zipcode: String
    let stateShort: String
    let countryShort: String
    let uploadReceipt: String
    let lat: String
    let lng: String
    let createdAt: String
    let updatedAt: String
    let status: String

    init(_ json: JSON) {
        if let id = json["id"].int {
            self.id = id
        }else {
            id = json["expense_id"].intValue
        }
        companyId = json["company_id"].stringValue
        loadId = json["load_id"].stringValue
        vendorId = json["vendor_id"].stringValue
        expenseType = json["expense_type"].stringValue
        type = json["type"].stringValue
        date = json["date"].stringValue
        amount = json["amount"].stringValue
        description = json["description"].stringValue
        unitId = json["unit_id"].stringValue
        galoons = json["galoons"].string ?? "0"
        refGallons = json["ref_gallons"].string ?? "0"
        defGallons = json["def_gallons"].string ?? "0"
        odometer = json["odometer"].stringValue
        country = json["country"].stringValue
        state = json["state"].stringValue
        city = json["city"].stringValue
        zipcode = json["zipcode"].stringValue
        stateShort = json["state_short"].stringValue
        countryShort = json["country_short"].stringValue
        uploadReceipt = json["upload_receipt"].stringValue
        lat = json["lat"].stringValue
        lng = json["lng"].stringValue
        createdAt = json["created_at"].stringValue
        updatedAt = json["updated_at"].stringValue
        status = json["status"].stringValue
    }
}
