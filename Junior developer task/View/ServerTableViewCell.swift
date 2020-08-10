//
//  ServerTableViewCell.swift
//  Junior developer task
//
//  Created by Daniel Šuškevič on 2020-08-09.
//  Copyright © 2020 Daniel Šuškevič. All rights reserved.
//

import UIKit

class ServerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setNameLabel(text: String) {
        nameLabel.text = text
    }
    
    func setDistanceLabel(text: String) {
        distanceLabel.text = text
    }
}
