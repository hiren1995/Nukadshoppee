//
//  WithdrawalCell.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 22/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import MarqueeLabel

class WithdrawalCell: UITableViewCell {

    @IBOutlet weak var lblDateOfClaim: MarqueeLabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblReferenceId: UILabel!
    @IBOutlet weak var lblAmountValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
