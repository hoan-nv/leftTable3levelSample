//
//  Child.swift
//  leftTable3levelDemo
//
//  Created by Nguyen Hoan on 9/10/20.
//  Copyright © 2020 Nguyen Hoan. All rights reserved.
//

import UIKit

class Child: UITableViewCell {

    @IBOutlet weak var tittle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
