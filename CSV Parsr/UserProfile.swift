//
//  UserProfile.swift
//  CSV Parsr
//
//  Created by Michal Lučanský on 27.5.18.
//  Copyright © 2018 MichalLucansky. All rights reserved.
//

import Foundation

struct UserProfile {
    
    var name:String = String()
    var id:String = String()
    var category:[UserCategory] = [UserCategory]()
    
    init(name:String, id:String, category: [UserCategory]) {
        self.name = name
        self.id = id
        self.category = category
    }
}

struct UserCategory {
    
    var id:String?
    var items:[UserItems] = [UserItems]()
    
//    init(id:String) {
//        self.id = id
////        self.items = items
//    }
}

struct UserItems {
    var id:String = String()
    
//    init(id:String) {
//        self.id = id
//    }
}
