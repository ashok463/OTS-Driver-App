//
//  DeliveryListViewModel.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 27/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class DeliveryListViewModel {

    var deliveryList: [DeliveryViewModel]
    
    init() {
        self.deliveryList = [DeliveryViewModel]()
    }
    
    init(list: JSON) {
        self.deliveryList = [DeliveryViewModel]()
        
        for data in list.arrayValue{
            self.deliveryList.append(DeliveryViewModel(delivery: data))
        }
        
    }
}
