//
//  VendorCell.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 19/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class VendorCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var vendorArea: UILabel!
    @IBOutlet weak var vendorDealsIn: UILabel!
    @IBOutlet weak var vendorRating: UILabel!
    @IBOutlet weak var vendorCall: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
