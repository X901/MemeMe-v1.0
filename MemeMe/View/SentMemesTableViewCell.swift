//
//  SentMemesTableViewCell.swift
//  MemeMe
//
//  Created by X901 on 21/10/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {

    @IBOutlet weak var topLable: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var imageViewMeme: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
