//
//  ClassTableViewCell.swift
//  Student Tool
//
//  Created by Jason Zhao on 8/13/17.
//  Copyright © 2017 N/A. All rights reserved.
//

import UIKit


class ClassTableViewCell: UITableViewCell {

    @IBOutlet weak var ClassName:UILabel!
    
    @IBOutlet var Credit: UILabel!
    
    
    @IBOutlet var Grade: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }
    
    
}
