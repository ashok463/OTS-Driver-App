//
//  BaseService.swift
//  OrderAte
//
//  Created by Gulfam Khan on 17/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BaseService {
    //MARK:- Shared data
    private var dataRequest:DataRequest?
    
    init() {}
    
    fileprivate var sessionManager:SessionManager {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        return manager
    }
    
    func getTokenParams() -> ParamsAny {
        return [DictKeys.userId:Global.shared.user?.id as Any,
                DictKeys.device_token:Global.shared.fcmToken]
    }
    
    //MARK:- Get API Call
    func makeGetAPICall(with completeURL:String, params:Parameters?,headers:HTTPHeaders? = nil,completion: @escaping (_ error: String, _ success: Bool, _ resultList:JSON?)->Void){
       
      dataRequest = sessionManager.request(completeURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers)
       
      dataRequest?
        .validate(statusCode: 200...500)
        .responseJSON(completionHandler: { response in
          switch response.result {
          case .success(let value):
            let json = JSON(value)
            let parsedResponse = ResponseHandler.handleResponse(json)
            
            if parsedResponse.serviceResponseType == .Success {
              completion(parsedResponse.message,true, parsedResponse.swiftyJsonData)
            }else{
              completion(parsedResponse.message,false,nil)
            }
             
          case .failure(let error):
            let errorMessage:String = error.localizedDescription
            print(errorMessage)
            completion(PopupMessages.SomethingWentWrong, false, nil)
          }
        })
       
    }
    
    //MARK:- Base POST API Call
    func makePostAPICall(with completeURL:String, params:Parameters?,successKey:String = KEY_RESULT_CODE,completion: @escaping (_ error: String, _ success: Bool, _ jsonData:JSON?)->Void){
        
        dataRequest = sessionManager.request(completeURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil)
        
        dataRequest?
            .validate(statusCode: 200...500)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let parsedResponse = ResponseHandler.handleResponse(json, successKey: successKey)
                    
                    if parsedResponse.serviceResponseType == .Success {
                        completion(parsedResponse.message,true, parsedResponse.swiftyJsonData)
                        print(parsedResponse.swiftyJsonData)
                        
                    }else {
                        completion(parsedResponse.message,false,nil)
                        print(parsedResponse.swiftyJsonData)
                    }
                    
                case .failure(let error):
                    let errorMessage:String = error.localizedDescription
                    print(errorMessage)
                    completion(PopupMessages.SomethingWentWrong, false,nil)
                }
            })
    }
    
    //MARK:- Multipart Post API Call
    func makePostAPICallWithMultipart(with completeURL:String, dict:[String:Data]?, params:[String:String], completion: @escaping (_ error: String, _ success: Bool, _ jsonData:JSON?)->Void) {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            
            // import image to request
            for (key, value) in dict ?? [:] {
                multipartFormData.append(value, withName: key,fileName: "image.jpg", mimeType: "image/jpg")
            }
        }, to: completeURL, headers:nil, encodingCompletion: {
            encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { (response) -> Void in
                    
                    switch response.result {
                        
                    case .success(let value):
                        let json = JSON(value)
                        let parsedResponse = ResponseHandler.handleResponse(json)
                        
                        if parsedResponse.serviceResponseType == .Success {
                            completion(parsedResponse.message,true, parsedResponse.swiftyJsonData)
                        }else {
                            completion(parsedResponse.message,false,nil)
                        }
                        
                    case .failure(let error):
                        let errorMessage:String = error.localizedDescription
                        print(errorMessage)
                        completion(PopupMessages.SomethingWentWrong, false, nil)
                    }
                    
                }
            case .failure(let encodingError):
                print(encodingError.localizedDescription)
            }
        })
//        upload(multipartFormData: { multipartFormData in
//
//
//            for (key, value) in params {
//                multipartFormData.append(value.data(using: .utf8)!, withName: key)
//            }
//
//            // import image to request
//            for (key, value) in dict ?? [:] {
//                multipartFormData.append(value, withName: key,fileName: "image.jpg", mimeType: "image/jpg")
//            }
//
//        }, to: completeURL, headers:nil, encodingCompletion: {
//            encodingResult in
//            switch encodingResult {
//            case .success(let upload, _, _):
//                upload.responseJSON { (response) -> Void in
//
//                    switch response.result {
//
//                    case .success(let value):
//                        let json = JSON(value)
//                        let parsedResponse = ResponseHandler.handleResponse(json)
//
//                        if parsedResponse.serviceResponseType == .Success {
//                            completion(parsedResponse.message,true, parsedResponse.swiftyJsonData)
//                        }else {
//                            completion(parsedResponse.message,false,nil)
//                        }
//
//                    case .failure(let error):
//                        let errorMessage:String = error.localizedDescription
//                        print(errorMessage)
//                        completion(PopupMessages.SomethingWentWrong, false, nil)
//                    }
//
//                }
//            case .failure(let encodingError):
//                print(encodingError.localizedDescription)
//            }
//        })
        
    }
    
    //MARK:- Multipart Post API Call
    func makePostAPICallWithMultipartNew(with completeURL:String, image0: Data?, image1: Data?, image2: Data?, image3: Data?, image4: Data?, image5: Data?, params:[String:String], imagePdf: String, completion: @escaping (_ error: String, _ success: Bool, _ jsonData:JSON?)->Void) {
        print(params)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if image0 == nil {
                    
                }else{
                    if imagePdf == "image"{
                        multipartFormData.append(image0!, withName: "image1", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }else{
                        multipartFormData.append(image0!, withName: "image1", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType:"application/pdf")
                    }
                    
                }
                
                if image1 == nil {
            
                }else{
                    if imagePdf == "image"{
                        multipartFormData.append(image1!, withName: "image2", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }else{
                        multipartFormData.append(image1!, withName: "image2", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType:"application/pdf")
                    }
                    
                }
                
                if image2 == nil {
                    
                }else{
                    if imagePdf == "image"{
                        multipartFormData.append(image2!, withName: "image3", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }else{
                        multipartFormData.append(image2!, withName: "image3", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType:"application/pdf")
                    }
                    
                }
                
                if image3 == nil {
                    
                }else{
                   if imagePdf == "image"{
                       multipartFormData.append(image3!, withName: "image4", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                   }else{
                       multipartFormData.append(image3!, withName: "image4", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType:"application/pdf")
                   }
                }
                
                if image4 == nil {
                    
                }else{
                   if imagePdf == "image"{
                       multipartFormData.append(image4!, withName: "image5", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                   }else{
                       multipartFormData.append(image4!, withName: "image5", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType:"application/pdf")
                   }
                }
                
                if image5 == nil {
                    
                }else{
                   if imagePdf == "image"{
                       multipartFormData.append(image5!, withName: "image6", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                   }else{
                       multipartFormData.append(image5!, withName: "image6", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType:"application/pdf")
                   }
                }
                
                for (key, value) in params {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
        }, to: completeURL, headers:nil, encodingCompletion: {
            encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { (response) -> Void in
                    
                    switch response.result {
                        
                    case .success(let value):
                        let json = JSON(value)
                        let parsedResponse = ResponseHandler.handleResponse(json)
                        
                        if parsedResponse.serviceResponseType == .Success {
                            completion(parsedResponse.message,true, parsedResponse.swiftyJsonData)
                        }else {
                            completion(parsedResponse.message,false,nil)
                        }
                        
                    case .failure(let error):
                        let errorMessage:String = error.localizedDescription
                        print(errorMessage)
                        completion(PopupMessages.SomethingWentWrong, false, nil)
                    }
                    
                }
            case .failure(let encodingError):
                print(encodingError.localizedDescription)
            }
        })
//        upload(multipartFormData: { multipartFormData in
//            
//            if image0 == nil {
//                
//            }else{
//                if imagePdf == "image"{
//                    multipartFormData.append(image0!, withName: "image1", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
//                }else{
//                    multipartFormData.append(image0!, withName: "image1", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType:"application/pdf")
//                }
//                
//            }
//            
//            if image1 == nil {
//        
//            }else{
//                if imagePdf == "image"{
//                    multipartFormData.append(image1!, withName: "image2", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
//                }else{
//                    multipartFormData.append(image1!, withName: "image2", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType:"application/pdf")
//                }
//                
//            }
//            
//            if image2 == nil {
//                
//            }else{
//                if imagePdf == "image"{
//                    multipartFormData.append(image2!, withName: "image3", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
//                }else{
//                    multipartFormData.append(image2!, withName: "image3", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType:"application/pdf")
//                }
//                
//            }
//            
//            if image3 == nil {
//                
//            }else{
//               if imagePdf == "image"{
//                   multipartFormData.append(image3!, withName: "image4", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
//               }else{
//                   multipartFormData.append(image3!, withName: "image4", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType:"application/pdf")
//               }
//            }
//            
//            if image4 == nil {
//                
//            }else{
//               if imagePdf == "image"{
//                   multipartFormData.append(image4!, withName: "image5", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
//               }else{
//                   multipartFormData.append(image4!, withName: "image5", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType:"application/pdf")
//               }
//            }
//            
//            if image5 == nil {
//                
//            }else{
//               if imagePdf == "image"{
//                   multipartFormData.append(image5!, withName: "image6", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
//               }else{
//                   multipartFormData.append(image5!, withName: "image6", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType:"application/pdf")
//               }
//            }
//            
//            for (key, value) in params {
//                multipartFormData.append(value.data(using: .utf8)!, withName: key)
//            }
//            
////            for image in Images {
////                multipartFormData.append(image, withName: "bol_upload", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
////            }
//            
//            // import image to request
////            for (key, value) in dict ?? [:] {
////                multipartFormData.append(value, withName: "bolupload[\()]",fileName: "image.jpg", mimeType: "image/jpg")
////            }
//            
//        }, to: completeURL, headers:nil, encodingCompletion: {
//            encodingResult in
//            switch encodingResult {
//            case .success(let upload, _, _):
//                upload.responseJSON { (response) -> Void in
//                    
//                    switch response.result {
//                        
//                    case .success(let value):
//                        let json = JSON(value)
//                        let parsedResponse = ResponseHandler.handleResponse(json)
//                        
//                        if parsedResponse.serviceResponseType == .Success {
//                            completion(parsedResponse.message,true, parsedResponse.swiftyJsonData)
//                        }else {
//                            completion(parsedResponse.message,false,nil)
//                        }
//                        
//                    case .failure(let error):
//                        let errorMessage:String = error.localizedDescription
//                        print(errorMessage)
//                        completion(PopupMessages.SomethingWentWrong, false, nil)
//                    }
//                    
//                }
//            case .failure(let encodingError):
//                print(encodingError.localizedDescription)
//            }
//        })
        
    }
    
}
