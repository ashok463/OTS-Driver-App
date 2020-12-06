//
//  SettlementTableViewCell.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 28/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

class SettlementTableViewCell: UITableViewCell {
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var lblInvoiceNumber: UILabel!
       @IBOutlet weak var lblPickupDate: UILabel!
       @IBOutlet weak var lblDropoffDate: UILabel!
       @IBOutlet weak var lblPickupFrom: UILabel!
       @IBOutlet weak var lblDeliverTo: UILabel!
       @IBOutlet weak var lblTotalMile: UILabel!
       @IBOutlet weak var lblLoadPay: UILabel!
       @IBOutlet weak var lblStatus: UILabel!
       @IBOutlet weak var btnPaid: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBack.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, cornerRadius: 10.0, radius: 5.0, edge: AIEdge.All, shadowSpace: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(data: SettlementViewModel){
        self.lblInvoiceNumber.text = data.invoice_number
        self.lblPickupDate.text = data.pickup_date
         self.lblDropoffDate.text = data.dropoff_date
         self.lblPickupFrom.text = data.pickup_from
         self.lblDeliverTo.text = data.deliver_to
         self.lblTotalMile.text = data.total_mile
         self.lblLoadPay.text = data.load_pay
         self.lblStatus.text = data.status
        
    }

}
