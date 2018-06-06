//
//  Database.swift
//  CSV Parsr
//
//  Created by Michal Lučanský on 6.6.18.
//  Copyright © 2018 MichalLucansky. All rights reserved.
//

import Foundation

struct Category {
    
    var id:String?
    var name:String?
    var active:String?
    
}

struct Product {
    var id:String?
    var name:String?
    var parentCategory:String?
}
