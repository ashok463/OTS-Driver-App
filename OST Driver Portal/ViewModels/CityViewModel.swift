//
//  CityViewModel.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 02/03/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class CityViewModel {
    
    //MARK:- data members
    var name:String
    
    //MARK:- Init methods
    init(_ jsonDict:JSON) {
        name = jsonDict["name"].stringValue
    }
}
