//
//  ServiceResponseType.swift
//  OrderAte
//
//  Created by Gulfam Khan on 12/09/2019.
//  Copyright © 2019 Rapidzz. All rights reserved.
//

import Foundation

public enum ServiceResponseType:String {
    
    case Success = "200"
    case Complete = "1" //200
    case Failure = "400"
    case FieldsRequired = "422"
    case Empty = "3"
    case Warning = "4"
    case Information = "5"
    case ValidationError = "6"
    case Exception = "500"
    case CodeWord = "8"
    case Redirect = "9"
    case Function = "10"
    case Code = "11"
    case Duplicate = "12"
    case AccessRights = "13"
    case DeActivated = "14"
    case ServerError = "15"
    case NoInternetConnection = "16"
    case Timeout = "101"
    case UnAuthorizeAccess = "102"
    case LoginCredentialsFailed = "17"
    
}
