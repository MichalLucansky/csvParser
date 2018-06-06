//
//  UsersViewModel.swift
//  CSV Parsr
//
//  Created by Michal Lučanský on 27.5.18.
//  Copyright © 2018 MichalLucansky. All rights reserved.
//

import Foundation

class UsersViewModel {
    
    var users = [UserProfile]()
    var categories = [Category]()
    var products = [Product]()
    init(users: [UserProfile], categories:[Category], products:[Product]) {
        self.users = users
        self.categories = categories
        self.products = products
    }
}
