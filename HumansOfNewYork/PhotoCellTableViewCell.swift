//
//  PhotoCellTableViewCell.swift
//  Tumblr
//
//  Created by Natalia Rodriguez on 9/15/17.
//  Copyright © 2017 Natalia Rodriguez. All rights reserved.
//

import UIKit

class PhotoCellTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
