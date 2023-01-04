//
//  UserAPI.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/3.
//

import UIKit

class UserAPI: APINetwork<UserInfo> {
    override var urlPath: String {
        return "/users/\(userName)"
    }
    
    var userName: String
    
    required init(userName: String) {
        self.userName = userName
        super.init()
    }
}

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
