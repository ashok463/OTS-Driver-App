//
//  LoadDataViewModel.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 27/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoadDataViewModel{
    
    var load_id: Int
    var company_id: String
    var invoice_number: String
    var truck_number: String
    var driver_name: String
    var trailer_number: String
    var pickup_date: String
    var pickup_from: String
    var pickup_time: String
    var delivery_date: String
    var delivery_to: String
    var delivery_time: String
    var status: String
    
    init() {
        self.load_id = 0
        self.company_id = ""
        self.invoice_number = ""
        self.truck_number = ""
        self.driver_name = ""
        self.trailer_number = ""
        self.pickup_date = ""
        self.pickup_from = ""
        self.pickup_time = ""
        self.delivery_date = ""
        self.delivery_to = ""
        self.delivery_time = ""
        self.status = ""
    }
    
    init(loadData: JSON) {
        self.load_id = loadData["load_id"].intValue
        self.company_id = loadData["company_id"].stringValue
        self.invoice_number = loadData["invoice_number"].stringValue
        self.truck_number = loadData["truck_number"].stringValue
        self.driver_name = loadData["driver_name"].stringValue
        self.trailer_number = loadData["trailer_number"].stringValue
        self.pickup_date = loadData["pickup_date"].stringValue
        self.pickup_from = loadData["pickup_from"].stringValue
        self.pickup_time = loadData["pickup_time"].stringValue
        self.delivery_date = loadData["delivery_date"].stringValue
        self.delivery_to = loadData["delivery_to"].stringValue
        self.delivery_time = loadData["delivery_time"].stringValue
        self.status = loadData["status"].stringValue
    }
    
    
}
