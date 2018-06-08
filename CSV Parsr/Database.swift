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

struct Product: Equatable {
    var id:String?
    var name:String?
    var parentCategory:String?
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name &&
            lhs.id == rhs.id
    }
}
