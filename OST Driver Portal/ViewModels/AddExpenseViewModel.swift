//
//  AddExpenseViewModel.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 29/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class AddExpenseViewModel {

    var loadId: String
    var unitId: String
    var companyId: String
    var addressComponents: AddressComponentsViewModel
    var categories = [CategoryViewModel]()
    var units = [UnitViewModel]()
    var vendors = [VendorViewModel]()

    init(_ json: JSON) {
        loadId = json["load_id"].stringValue
        unitId = json["unit_id"].stringValue
        companyId = json["company_id"].stringValue
        addressComponents = AddressComponentsViewModel(json["address_components"])
        units = json["units"].arrayValue.map { UnitViewModel($0) }
        vendors = json["vendors"].arrayValue.map { VendorViewModel($0) }
        let catList = json["categories"].arrayValue.map { CategoryViewModel($0) }
         categories = [CategoryViewModel(name: "Fuel"),
                       CategoryViewModel(name: "Maintainance")]
        categories.append(contentsOf: catList)
        categories.append(CategoryViewModel(name: "Others"))
        
    }

}
