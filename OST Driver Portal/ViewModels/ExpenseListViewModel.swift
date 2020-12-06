//
//  ExpenseListViewModel.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 29/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import SwiftyJSON

class ExpenseListViewModel {
    
    //MARK:- data members
    var expenseList = [ExpenseViewModel]()
    
    //MARK:- Init methods
    init() {
        expenseList = []
    }
    
    convenience init(_ jsonDict:JSON) {
        self.init()
        for json in jsonDict.arrayValue {
            let expense = ExpenseViewModel(json)
            self.expenseList.append(expense)
        }
    }
    
    func removeObjectWith(id:Int) {
        self.expenseList.removeAll(where: {$0.id == id})
    }
}
