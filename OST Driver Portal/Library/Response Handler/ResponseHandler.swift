//
//  ResponseHandler.swift
//  OrderAte
//
//  Created by Gulfam Khan on 12/09/2019.
//  Copyright © 2019 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

let KEY_RESULT_CODE = "success"
let KEY_RESPONSE_MESSAGE = "message"
let KEY_RESPONSE_DATA = "data"

class ResponseHandler {
    
    class func handleResponse(_ response:JSON, successKey:String = KEY_RESULT_CODE) -> ParsedResponseMessage {
        let parsedResponseMessage = ParsedResponseMessage()
        let resultCode = response[successKey].boolValue
        let resultMessage = response[KEY_RESPONSE_MESSAGE].stringValue
        
        parsedResponseMessage.message = resultMessage
        
        switch resultCode {
        case true:
            parsedResponseMessage.serviceResponseType = .Success
            parsedResponseMessage.swiftyJsonData = response
        default:
            parsedResponseMessage.data = nil
            parsedResponseMessage.swiftyJsonData = nil
            parsedResponseMessage.serviceResponseType = .Failure
        }
        
        return parsedResponseMessage
    }
}
