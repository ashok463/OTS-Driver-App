//
//  DeliveryViewModel.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 27/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class DeliveryViewModel{
    
    var id: Int
    var load_id: String
    var consignee: String
    var delivery_date: String
    var delivery_time: String
    var address: String
    var zip_code: String
    var contact_number: String
    var instructions: String
    var status_message: String
    var status: String
    var shouldShowButton = false
    
    init(){
        self.id = 0
        self.load_id = ""
        self.consignee = ""
        self.delivery_date = ""
        self.delivery_time = ""
        self.address = ""
        self.zip_code = ""
        self.contact_number = ""
        self.instructions = ""
        self.status_message = ""
        self.status = ""
    }
    
    init(delivery: JSON){
        self.id = delivery["id"].intValue
        self.load_id = delivery["load_id"].stringValue
        self.consignee = delivery["consignee"].stringValue
        self.delivery_date = delivery["delivery_date"].stringValue
        self.delivery_time = delivery["delivery_time"].stringValue
        self.address = delivery["address"].stringValue
        self.zip_code = delivery["zip_code"].stringValue
        self.contact_number = delivery["contact_number"].stringValue
        self.instructions = delivery["instructions"].stringValue
        self.status_message = delivery["status_message"].stringValue
        self.status = delivery["status"].stringValue
    }
    
    
    
    
    
}
