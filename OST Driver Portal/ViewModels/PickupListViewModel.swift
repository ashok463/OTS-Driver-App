//
//  PickupListViewModel.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 26/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class PickupListViewModel {
    
    var pickupList: [PickupViewModel]
    
    init(){
        self.pickupList = [PickupViewModel]()
        
    }
    
    init(list: JSON){
        self.pickupList = [PickupViewModel]()
        for data in list.arrayValue{
            self.pickupList.append(PickupViewModel(pickupData: data))
        }
    }
    
}

