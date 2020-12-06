//
//  API.swift
//  Zon Bau
//
//  Created by Gulfam Khan on 04/09/2019.
//  Copyright © 2019 AcclivousByte. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RegisterationService: BaseService {
    
    //MARK:- Shared Instance
    private override init() {}
    static func shared() -> RegisterationService {
        return RegisterationService()
    }
    
    fileprivate func saveUserInfo(_ userInfo:UserLoginViewModel) {
        Global.shared.user = userInfo
        UserDefaultsManager.shared.isUserLoggedIn = true
        UserDefaultsManager.shared.loggedInUserInfo = userInfo
    }
    
    //MARK:- Resgister user API
    func registerUser(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool, _ userInfo:UserViewModel)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.userRegisterUrl
        self.makePostAPICall(with: completeURL, params: params) { (message, success, json) in
            if success {
                let userProfile = UserViewModel(jsonDict: json![KEY_RESPONSE_DATA])
                completion(message,success,userProfile)
            }
        }
    }
    
    //MARK:- Login user API
    func getUserLogin(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool, _ userInfo: UserLoginViewModel?)->Void){
        let completeURL = EndPoints.BASE_URL + EndPoints.loginUrl
        self.makePostAPICall(with: completeURL, params: params) { (message, success, json) in
            if success {
                let userProfile = UserLoginViewModel(user: json![KEY_RESPONSE_DATA])
                self.saveUserInfo(userProfile)
                GCD.async(.Background, delay: 2) {
                    completion(message,success,userProfile)
                }
            }else {
                completion(message,success,nil)
            }
        }
    }
    
    //MARK: - LOAD DATA API
    func loadDataDetail(params: Parameters,complition: @escaping (_ Error: String, _ success: Bool, _ dispatchDataModel: DispatchViewModel?) -> Void){
        let completeURL = EndPoints.BASE_URL + EndPoints.load_details
        self.makePostAPICall(with: completeURL, params: params) { (message, success, json) in
            if success{
                let loadData = DispatchViewModel(dispatch: json![KEY_RESPONSE_DATA])
                complition(message, success, loadData)
            }
            else{
                complition(message, success, nil)
            }
        }
    }
    
    //MARK: - CHECK VERSION API
    func checkVersion(params: Parameters, complition: @escaping (_ Error: String, _ sucess: Bool, _ checkVersion: CheckVersionViewModel?) -> Void){
        let completeURL = EndPoints.BASE_URL + EndPoints.checkversion
        print(completeURL)
//        self.makeGetAPICall(with: completeURL, params: params)
        self.makePostAPICall(with: completeURL, params: params){ (message, success, json) in
            if success{
                let result = CheckVersionViewModel(version: json![KEY_RESPONSE_DATA])
                complition(message, success, result)
            }else{
                complition(message, success, nil)
            }
        }
    }
    
    //MARK: - CKECK TOKEN API
    func checkToken(complition: @escaping(_ error: String, _ success: Bool, _ checkTokenData: JSON? )-> Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.checktoken
        print(self.getTokenParams())
        print(completeURL)
        self.makePostAPICall(with: completeURL, params: self.getTokenParams()) { (message, success, json) in
            if success{
                complition(message, success, json )
            }else{
                complition(message, success, nil)
            }
        }
    }
    
    //MARK: - CHANGE PICKUP AND DELIVERY STATUS API
    func PickupDeliveryStatus(params: Parameters, complition: @escaping(_ Error: String, _ success: Bool, _ PickupDeliveryData: JSON?) -> Void){
        let completeURL = EndPoints.BASE_URL + EndPoints.changestatus
        self.makePostAPICall(with: completeURL, params: params) { (message, success, json) in
            if success{
                complition(message, success, json)
            }else{
                complition(message, success, nil)
            }
        }
    }
    //MARK: - UPLOAD BOL API
    func uploadBol(params: [String:String], dict: [String: Data], complition: @escaping(_ error: String, _ success: Bool, _ uploadBolData: JSON?) -> Void){
        let completeURL = EndPoints.BASE_URL + EndPoints.uploadbol
        self.makePostAPICallWithMultipart(with: completeURL, dict: dict, params: params) { (message, success, json) in
            if success{
                complition(message, success, json)
            }else{
                complition(message, success, nil)
            }
        }
    }
    //MARK: - UPLOAD BOL API
       func uploadBolWithDelivery(params: [String:String], dict: [String: Data], complition: @escaping(_ error: String, _ success: Bool, _ uploadBolData: JSON?) -> Void){
           let completeURL = EndPoints.BASE_URL + EndPoints.bol_delivery
           self.makePostAPICallWithMultipart(with: completeURL, dict: dict, params: params) { (message, success, json) in
               if success{
                   complition(message, success, json)
               }else{
                   complition(message, success, nil)
               }
           }
       }
    
    //MARK: - UPLOAD BOL New API   /* Ashok */
    func uploadBolWithDeliveryNew(params: [String:String], image0: Data?, image1: Data?, image2: Data?, image3: Data?, image4: Data?, image5: Data?, imagePdf: String, complition: @escaping(_ error: String, _ success: Bool, _ uploadBolData: JSON?) -> Void){
        let completeURL = EndPoints.BASE_URL + EndPoints.bol_delivery
        self.makePostAPICallWithMultipartNew(with: completeURL, image0: image0, image1: image1, image2: image2, image3: image3, image4: image4, image5: image5, params: params, imagePdf: imagePdf) { (message, success, json) in
            if success{
                print("message: \(message)")
                print("success: \(success)")
                print("jason: \(String(describing: json))")
                complition(message, success, json)
            }else{
                complition(message, success, nil)
            }
        }
    }
    
    //MARK: - SETTLEMENT API
    func settlementDetail(params: Parameters, complition: @escaping (_ Error: String, _ success: Bool, _ SettlementDataModel: SettlementListViewModel?) -> Void){
        let completeURL = EndPoints.BASE_URL + EndPoints.settlement
        self.makePostAPICall(with: completeURL, params: params) { (message, success, json) in
            if success{
                let loadData = SettlementListViewModel(list: json![KEY_RESPONSE_DATA])
                complition(message, success, loadData)
            }else{
                complition(message, success, nil)
            }
        }
    }
}
