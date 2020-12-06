//
//  DispatchViewModel.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 27/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class DispatchViewModel {
    
    var shouldShowPickupButton = true
    var shouldShowDeliveryButton = false
    
    var loadData: LoadDataViewModel
    var pikups: PickupListViewModel
    var deliverys: DeliveryListViewModel
    
    init() {
        self.loadData = LoadDataViewModel()
        self.pikups = PickupListViewModel()
        self.deliverys = DeliveryListViewModel()
    }
    
    init(dispatch: JSON) {
        self.loadData = LoadDataViewModel(loadData: dispatch["load_data"])
        self.pikups = PickupListViewModel(list: dispatch["pickups"])
        self.deliverys = DeliveryListViewModel(list: dispatch["deliverys"])
        
        self.checkForPickupsDeliveries()
        
    }
    
    func checkForPickupsDeliveries() {
        let pickups = pikups.pickupList.filter {$0.status == "0"}
        if pickups.count > 0 {
            self.shouldShowPickupButton = true
            self.shouldShowDeliveryButton = false
            pickups.first?.shouldShowButton = true
        }else if ((deliverys.deliveryList.filter {$0.status == "0"}).count > 0) {
            self.shouldShowPickupButton = false
            
            let deliveries = deliverys.deliveryList.filter {$0.status == "0"}
            if deliveries.count > 0 {
                self.shouldShowDeliveryButton = true
                deliveries.first?.shouldShowButton = true
            }
        }else{
            self.shouldShowPickupButton = true
            self.shouldShowDeliveryButton = false
        }
    }
    func isLastToDeliever() -> Bool{
        let pickups = deliverys.deliveryList.filter {$0.status == "0"}
        if pickups.count == 1{
            return true
        }
        return false
    }
    func getLastDelieveryId() -> Int{
        return deliverys.deliveryList[deliverys.deliveryList.count - 1].id
    }
    
}
