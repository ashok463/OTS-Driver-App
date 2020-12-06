//
//  EditExpenseDataViewModel.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 05/03/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class EditExpenseDataViewModel {

    let loadId: String
    let companyId: String
    let expenseData: ExpenseViewModel
    var categories: [CategoryViewModel]
    let units: [UnitViewModel]
    let vendors: [VendorViewModel]

    init(_ json: JSON) {
        loadId = json["load_id"].stringValue
        companyId = json["company_id"].stringValue
        expenseData = ExpenseViewModel(json["expense_data"])
        units = json["units"].arrayValue.map { UnitViewModel($0) }
        vendors = json["vendors"].arrayValue.map { VendorViewModel($0) }
        let catList = json["categories"].arrayValue.map { CategoryViewModel($0) }
         categories = [CategoryViewModel(name: "Fuel"),
                       CategoryViewModel(name: "Maintainance")]
        categories.append(contentsOf: catList)
        categories.append(CategoryViewModel(name: "Others"))
    }

}
