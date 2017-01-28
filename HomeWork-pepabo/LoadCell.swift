//
//  LoadCell.swift
//  HomeWork-pepabo
//
//  Created by 西村歩夢 on 2017/01/28.
//  Copyright © 2017年 西村歩夢. All rights reserved.
//

import UIKit

class LoadCell: UITableViewCell {

    @IBOutlet weak var load: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        load.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
