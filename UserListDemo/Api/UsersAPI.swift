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
    
    required init(sinceId: Int, perPage: Int) {
        super.init()
        self.parameters = [
            "since": sinceId,
            "per_page": perPage
        ]
    }
}
