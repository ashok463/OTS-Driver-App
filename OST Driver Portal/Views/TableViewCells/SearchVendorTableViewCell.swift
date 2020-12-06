//
//  SearchVendorTableViewCell.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 25/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

protocol SearchVendorTableViewCellDelegate: NSObjectProtocol {
    func callSetTitle(title: UILabel)
}

class SearchVendorTableViewCell: UITableViewCell {
    
     @IBOutlet weak var lblTitle: UILabel!
    
   weak var delegate: SearchVendorTableViewCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    

}
