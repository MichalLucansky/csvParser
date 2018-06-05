//
//  ProfileTableViewCell.swift
//  CSV Parsr
//
//  Created by Michal Lučanský on 5.6.18.
//  Copyright © 2018 MichalLucansky. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(name:String){
        categoryName.text = name
    }
    

}
