//
//  UserInfo.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/3.
//

import UIKit

struct UserInfo: Codable {
    var login: String?
    var id: Int?
    var avatarUrl: String?
    var htmlUrl: String?
    var admin: Bool?
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case admin = "site_admin"
    }
}
