//
//  SettlementListViewModel.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 27/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class SettlementListViewModel {
    var settlementList : [SettlementViewModel]
    
    init() {
        self.settlementList = [SettlementViewModel]()
    }
    
    init(list: JSON){
        self.settlementList = [SettlementViewModel]()
        
        for result in list.arrayValue{
            self.settlementList.append(SettlementViewModel(settlement: result))
        }
    }
}
