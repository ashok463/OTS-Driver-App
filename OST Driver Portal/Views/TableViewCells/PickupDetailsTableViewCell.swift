//
//  PickupDetailsTableViewCell.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 19/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

class PickupDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblPickup: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lblShipperR: UILabel!
    @IBOutlet weak var lblPickupDateR: UILabel!
    @IBOutlet weak var lblPickupTimeR: UILabel!
    @IBOutlet weak var lblShipperInstruction: UILabel!
    @IBOutlet weak var btnSubmitPickup: UIButton!
    @IBOutlet weak var btnSubmitHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var lblShipper: UILabel!
    @IBOutlet weak var lblPickupDate: UILabel!
    @IBOutlet weak var lblPickupTime: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var txtInstruction: UITextView!
    @IBOutlet weak var lblAddressTitle: UILabel!
    @IBOutlet weak var lblAddressValue: UILabel!
    @IBOutlet weak var DirectionBtn: UIButton!
    
    var isDelivery = false
    var index = -1
    var delivery:DeliveryViewModel!
    var pickup:PickupViewModel!
    weak var delegate: PickupDetailsTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  //MARK: - ACTION METHODS
    @IBAction func actionSubmitPickup(_ sender: UIButton){
        delegate.callapiCall(self.isDelivery,delivery:self.delivery, pickup: pickup)
    }
    
    @IBAction func actionDirection(_ sender: UIButton){
        delegate.callBackActionDirection(index: index)
    }
    
    //MARK:- FUNCTION
    func setupBtnSubmitVisibility(_ hidden:Bool) {
        if hidden {
            self.btnSubmitHeight.constant = 0
            btnSubmitPickup.isHidden = true
            self.setNeedsLayout()
        }else {
            self.btnSubmitHeight.constant = 50
            btnSubmitPickup.isHidden = false
            self.setNeedsLayout()
        }
        self.layoutIfNeeded()
    }
    
    func configure(with pickupModel:PickupViewModel, deliveryOption:Bool) {
        self.isDelivery = false
        self.pickup = pickupModel
        self.lblShipper.text = pickupModel.shipper
        self.lblPickupDate.text = pickupModel.pickup_date
        self.lblPickupTime.text = pickupModel.pickup_time
        self.lblStatus.text = pickupModel.status_message
//        self.lblAddressValue.text = pickupModel.address /* Ashok */
        self.txtInstruction.text = pickupModel.instructions
        
        if pickupModel.status != "1" && deliveryOption {
            lblAddressTitle.text = kBlankString
            lblAddressValue.text = kBlankString
            DirectionBtn.isHidden = true
        }else{
            /* Ashok */
            lblAddressTitle.text = "Address:"
            lblAddressValue.text = pickupModel.address
            DirectionBtn.isHidden = false
        }
        
        self.pickupNames()
        self.setupBtnSubmitVisibility(deliveryOption)
        
    }
    
    func configure(with deliveryModel:DeliveryViewModel, deliveryOption:Bool) {
        self.isDelivery = true
        self.delivery = deliveryModel
        self.lblShipper.text = deliveryModel.consignee
        self.lblPickupDate.text = deliveryModel.delivery_date
        self.lblPickupTime.text = deliveryModel.delivery_time
        self.lblStatus.text = deliveryModel.status_message
//        self.lblAddressValue.text = deliveryModel.address /* Ashok */
        self.txtInstruction.text = deliveryModel.instructions
        
        print(deliveryModel.address)
        if deliveryModel.status != "1" && deliveryOption {
            lblAddressTitle.text = kBlankString
            lblAddressValue.text = kBlankString
            DirectionBtn.isHidden = true
        }else{
            /* Ashok */
            lblAddressTitle.text = "Address:"
            lblAddressValue.text = deliveryModel.address
            DirectionBtn.isHidden = false
        }
        
        self.deliveryNames()
        self.setupBtnSubmitVisibility(deliveryOption)
    }
    
    func deliveryNames(){
        self.lblPickup.text = "Delivery "
        self.lblShipperR.text = "Consignee:"
        self.lblPickupDateR.text = "Delivery Date:"
        self.lblPickupTimeR.text = "Delivery Time:"
        self.lblShipperInstruction.text = "Delivery Instruction:"
        self.btnSubmitPickup.setTitle("SUBMIT DELIVERY", for: .normal)

    }
    
    func pickupNames(){
        self.lblPickup.text = "Pickup "
        self.lblShipperR.text = "Shipper:"
        self.lblPickupDateR.text = "Pickup Date:"
        self.lblPickupTimeR.text = "Pickup Time:"
        self.lblShipperInstruction.text = "Shipper Instruction:"
        self.btnSubmitPickup.setTitle("SUBMIT PICKUP", for: .normal)
    }
    
    
}
