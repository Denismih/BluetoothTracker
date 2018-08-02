//
//  BlueTableViewCell.swift
//  BluetoothTracker
//
//  Created by Admin on 02.08.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class BlueTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var rssiLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            
        }
    }

}
