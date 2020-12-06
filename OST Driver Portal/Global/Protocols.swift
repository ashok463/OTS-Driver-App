//
//  LocalizationProtocols.swift
//  OrderAte
//
//  Created by Gulfam Khan on 19/09/2019.
//  Copyright © 2019 Rapidzz. All rights reserved.
//

import UIKit
import Foundation

protocol ExpenseTableViewCellDelegate: class {
    func callViewDetail(_ expense:ExpenseViewModel)
    func callEditDetail(_ expense:ExpenseViewModel)
    func didTapDelete(_ expense:ExpenseViewModel)
}

protocol MainContainerViewControllerDelegate: class {
    func callBack()
    func callBackHome()
    func callAddController()
}
extension MainContainerViewControllerDelegate {
   
    func callBackHome(){}
    func callAddController(){}
}

protocol PickupDetailsTableViewCellDelegate: class {
    func callapiCall(_ isDelivery:Bool, delivery:DeliveryViewModel?, pickup:PickupViewModel?)
    func callBackActionDirection(index : Int)
}

protocol VendorsDelegate: class {
    func didSelect(vendor: VendorViewModel)
    func shouldUpdateExpenseData()
}

protocol Localizable {
    var localized: String { get }
}

protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

extension String: Localizable {
    var localized: String {
        let loc = UserDefaultsManager.shared.currentLocale
        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")//
    }
}

extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key, for: .normal)
        }
    }
}

extension UITextField: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            placeholder = key
        }
    }
}
