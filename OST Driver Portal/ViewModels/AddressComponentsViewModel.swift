//
//  AddressComponentsViewModel.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 29/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class AddressComponentsViewModel {

    let city: String
    let postalCode: String
    let stateLongname: String
    let stateShortname: String
    let countryLongname: String
    let countryShortname: String
    let formattedAddress: String

    init(_ json: JSON) {
        city = json["city"].stringValue
        postalCode = json["postal_code"].stringValue
        stateLongname = json["state_longname"].stringValue
        stateShortname = json["state_shortname"].stringValue
        countryLongname = json["country_longname"].stringValue
        countryShortname = json["country_shortname"].stringValue
        formattedAddress = json["formatted_address"].stringValue
    }

}
