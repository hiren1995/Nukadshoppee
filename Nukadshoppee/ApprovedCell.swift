//
//  ApprovedCell.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 20/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit

class ApprovedCell: UITableViewCell {

    @IBOutlet weak var lblShopName: UILabel!
    @IBOutlet weak var lblInoviceNum: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblExpires: UILabel!
    @IBOutlet weak var lblAmtValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
