//
//  ExpenseService.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 29/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import Alamofire

class ExpenseService: BaseService {
    
    //MARK:- Shared Instance
    private override init() {}
    static func shared() -> ExpenseService {
        return ExpenseService()
    }
    
    //MARK:- GET Expense List
    func loadAllExpenses(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool, _ userInfo:ExpenseListViewModel?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.loadExpences
        self.makePostAPICall(with: completeURL, params: params) { (message, success, json) in
            if success {
                let expences = ExpenseListViewModel(json![KEY_RESPONSE_DATA])
                completion(message,success,expences)
            }else {
                completion(message,success,nil)
            }
        }
    }
    
    //MARK:- Delete Expense
    func deleteExpense(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.deleteExpense
        self.makePostAPICall(with: completeURL, params: params) { (message, success, json) in
            completion(message,success)
        }
    }
    
    //MARK:- GET Add Expense Data
    func getExpenseData(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool, _ userInfo:AddExpenseViewModel?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.addexpense
        self.makePostAPICall(with: completeURL, params: params) { (message, success, json) in
            if success {
                let expences = AddExpenseViewModel(json![KEY_RESPONSE_DATA])
                completion(message,success,expences)
            }else {
                completion(message,success,nil)
            }
        }
    }
    
    //MARK:- Get States
    func getStatesList(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool, _ userInfo:[StateViewModel]?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.getstates
        self.makePostAPICall(with: completeURL, params: params, successKey: "status") { (message, success, json) in
            if success {
                let states = json![KEY_RESPONSE_DATA].arrayValue.map({StateViewModel($0)})
                completion(message,success,states)
            }else {
                completion(message,success,nil)
            }
        }
    }
    
    //MARK:- Get Cities
    func getCitiesList(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool, _ userInfo:[CityViewModel]?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.getcities
        self.makePostAPICall(with: completeURL, params: params, successKey: "status") { (message, success, json) in
            if success {
                let states = json![KEY_RESPONSE_DATA].arrayValue.map({CityViewModel($0)})
                completion(message,success,states)
            }else {
                completion(message,success,nil)
            }
        }
    }
    
    //MARK:- Add Expenses
    func addExpenes(image0: Data?, image1: Data?, image2: Data?, image3: Data?, image4: Data?, image5: Data?, imagePdf: String, params:ParamsString,completion: @escaping (_ error: String, _ success: Bool)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.saveexpense
//        self.makePostAPICallWithMultipart(with: completeURL, dict: imageDict, params: params) { (message, success, json) in
//            completion(message,success)
//        }
        self.makePostAPICallWithMultipartNew(with: completeURL, image0: image0, image1: image1, image2: image2, image3: image3, image4: image4, image5: image5, params: params, imagePdf: imagePdf) { (message, success, json) in
        completion(message,success)
        }
    }
    
    //MARK:- Add Expenses
    func addVendor(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.addvendor
        self.makePostAPICall(with: completeURL, params: params, successKey: "status") { (message, success, json) in
            completion(message,success)
        }
    }
    
    //MARK:- GET Edit Expense Data
    func getEditExpenseData(params:Parameters?,completion: @escaping (_ error: String, _ success: Bool, _ userInfo:EditExpenseDataViewModel?)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.editexpense
        self.makePostAPICall(with: completeURL, params: params) { (message, success, json) in
            if success {
                let expences = EditExpenseDataViewModel(json![KEY_RESPONSE_DATA])
                completion(message,success,expences)
            }else {
                completion(message,success,nil)
            }
        }
    }
    
    //MARK:- Add Expenses
    func saveEditedExpene(imageDict:[String:Data] = [:], image0: Data?, image1: Data?, image2: Data?, image3: Data?, image4: Data?, image5: Data?, imagePdf: String, params:ParamsString,completion: @escaping (_ error: String, _ success: Bool)->Void){
        
        let completeURL = EndPoints.BASE_URL + EndPoints.updateexpense
//        self.makePostAPICallWithMultipart(with: completeURL, dict: imageDict, params: params) { (message, success, json) in
//            completion(message,success)
//        }
        self.makePostAPICallWithMultipartNew(with: completeURL, image0: image0, image1: image1, image2: image2, image3: image3, image4: image4, image5: image5, params: params, imagePdf: imagePdf) { (message, success, json) in
            completion(message,success)
        }
    }
    
}
