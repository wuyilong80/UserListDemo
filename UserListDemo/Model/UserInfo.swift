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
    var admin: Bool?
    var bio: String?
    var location: String?
    var blog: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case avatarUrl = "avatar_url"
        case admin = "site_admin"
        case bio = "bio"
        case location = "location"
        case blog = "blog"
        case name = "name"
    }
}
