//
//  UserTableViewCell.swift
//  CSV Parsr
//
//  Created by Michal Lučanský on 27.5.18.
//  Copyright © 2018 MichalLucansky. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {


    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var label: UIView!
    
    func setUpView(user: UserProfile) {
            self.userNameLabel.text = user.name
//            self.detailLabel.text = user.category[0]
    }
    
}
