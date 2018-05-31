//
//  UserProfile.swift
//  CSV Parsr
//
//  Created by Michal Lučanský on 27.5.18.
//  Copyright © 2018 MichalLucansky. All rights reserved.
//

import Foundation

struct UserProfile {
    
    var name:String?
    var mainCategory:String?
    var subCategory:String?
    var detail:String?
    
    init(name:String, mainCategory:String, subCategory:String, detail:String) {
        self.name = name
        self.mainCategory = mainCategory
        self.subCategory = subCategory
        self.detail = detail
        
    }
}
