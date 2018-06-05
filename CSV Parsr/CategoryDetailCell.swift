//
//  CategoryDetailCell.swift
//  CSV Parsr
//
//  Created by Michal Lučanský on 5.6.18.
//  Copyright © 2018 MichalLucansky. All rights reserved.
//

import UIKit

class CategoryDetailCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(name:String){
        itemLabel.text = name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
