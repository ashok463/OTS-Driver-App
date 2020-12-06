//
//  StateViewModel.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 29/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class StateViewModel {
    
    //MARK:- data members
    var name:String
    
    //MARK:- Init methods
    init(_ jsonDict:JSON) {
        name = jsonDict["name"].stringValue
    }
}
