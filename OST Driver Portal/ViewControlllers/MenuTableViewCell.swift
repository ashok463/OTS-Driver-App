//
//  MenuTableViewCell.swift
//  OTS Manager
//
//  Created by Ashok Kumar on 21/08/20.
//  Copyright © 2020 Ashok Kumar. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImgView: UIImageView!
    @IBOutlet weak var heightConstraintItemImgView: NSLayoutConstraint!
    @IBOutlet weak var widthConstraintItemImgView: NSLayoutConstraint!
    @IBOutlet weak var itemNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            
            heightConstraintItemImgView.constant = 80
            widthConstraintItemImgView.constant = 0
            itemNameLbl.font = itemNameLbl.font.withSize(36)
        }else{
            
            heightConstraintItemImgView.constant = 80
            widthConstraintItemImgView.constant = 0
            itemNameLbl.font = itemNameLbl.font.withSize(18)
        }
        
        itemImgView.cornerRadiusImageView(radius: itemImgView.frame.size.height/2)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}



