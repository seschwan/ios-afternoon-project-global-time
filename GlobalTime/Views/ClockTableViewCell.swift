//
//  ClockTableViewCell.swift
//  GlobalTime
//
//  Created by Seschwan on 6/27/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

import UIKit

class ClockTableViewCell: UITableViewCell {
    
    @IBOutlet weak var clockView: ClockView!
    @IBOutlet weak var timeZoneLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
