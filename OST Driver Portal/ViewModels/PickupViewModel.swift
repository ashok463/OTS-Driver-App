//
//  PickupViewModel.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 26/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class PickupViewModel {
    
    var id: Int
    var load_id: String
    var shipper: String
    var pickup_date: String
    var pickup_time: String
    var address: String
    var zip_code: String
    var contact_number: String
    var instructions: String
    var status_message: String
    var status: String
    var shouldShowButton = false
    
    init() {
        self.id = 0
        self.load_id = ""
        self.shipper = ""
        self.pickup_date = ""
        self.pickup_time = ""
        self.address = ""
        self.zip_code = ""
        self.contact_number = ""
        self.instructions = ""
        self.status_message = ""
        self.status = ""
    }
    
    init(pickupData: JSON){
        self.id = pickupData["id"].intValue
        self.load_id = pickupData["load_id"].stringValue
        self.shipper = pickupData["shipper"].stringValue
        self.pickup_date = pickupData["pickup_date"].stringValue
        self.pickup_time = pickupData["pickup_time"].stringValue
        self.address = pickupData["address"].stringValue
        self.zip_code = pickupData["zip_code"].stringValue
        self.contact_number = pickupData["contact_number"].stringValue
        self.instructions = pickupData["instructions"].stringValue
        self.status_message = pickupData["status_message"].stringValue
        self.status = pickupData["status"].stringValue
        
    }
    
}


