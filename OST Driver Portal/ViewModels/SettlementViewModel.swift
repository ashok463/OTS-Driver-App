//
//  SettlementViewModel.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 27/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class SettlementViewModel {
    
    var invoice_number: String
    var pickup_date: String
    var dropoff_date: String
    var pickup_from: String
    var deliver_to: String
    var total_mile: String
    var load_pay: String
    var status: String
    
    init() {
        self.invoice_number = ""
        self.pickup_date = ""
        self.dropoff_date = ""
        self.pickup_from = ""
        self.deliver_to = ""
        self.total_mile = ""
        self.load_pay = ""
        self.status = ""
    }
    
    init(settlement: JSON) {
        self.invoice_number = settlement["invoice_number"].stringValue
        self.pickup_date = settlement["pickup_date"].stringValue
        self.dropoff_date = settlement["dropoff_date"].stringValue
        self.pickup_from = settlement["pickup_from"].stringValue
        self.deliver_to = settlement["deliver_to"].stringValue
        self.total_mile = settlement["total_mile"].stringValue
        self.load_pay = settlement["load_pay"].stringValue
        self.status = settlement["status"].stringValue
    }
}
