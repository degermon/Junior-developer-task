//
//  RoundedButtonClass.swift
//  Junior developer task
//
//  Created by Daniel Šuškevič on 2020-08-09.
//  Copyright © 2020 Daniel Šuškevič. All rights reserved.
//

import UIKit

class RoundedButon: UIButton { // simple button class with rounded corners
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = true
        setBorder()
    }
    
    func setBorder(borderWidth: CGFloat = 1.0, borderColor: CGColor = UIColor.blue.cgColor) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
}
