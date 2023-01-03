//
//  UserAPI.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/3.
//

import UIKit

class UsersAPI: APINetwork<[UserInfo]> {
    
    override var urlPath: String {
        return "/users"
    }
    
    required init(perPage: Int) {
        super.init()
        self.parameters = ["per_page": perPage]
    }
}
