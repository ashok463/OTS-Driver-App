//
//  ExpenseTableViewCell.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 18/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lblVendor: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblZipcode: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!

    var expense:ExpenseViewModel!
   weak var delegate: ExpenseTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, cornerRadius: 10.0, radius: 5.0, edge: AIEdge.All, shadowSpace: 20)
    }
    
    func configure(with expenseModel:ExpenseViewModel) {
        expense = expenseModel
        lblVendor.text = expenseModel.vendorId
        lblDate.text = expenseModel.date
        lblType.text = expenseModel.type
        lblAmount.text = expenseModel.amount
        lblState.text = expenseModel.state
        lblZipcode.text = expenseModel.zipcode
        print(expenseModel.uploadReceipt)
    }

    @IBAction func actionEdit(_ sender:UIButton){
        delegate?.callEditDetail(expense)
    }
    @IBAction func actionDelete(_ sender:UIButton){
        delegate?.didTapDelete(expense)
    }
    @IBAction  func actionViewDetails(_ sender:UIButton){
        delegate?.callViewDetail(expense)
        
    }
   
    
}
