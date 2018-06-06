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
    init(users: [UserProfile], categories:[Category]) {
        self.users = users
        self.categories = categories
    }
}
