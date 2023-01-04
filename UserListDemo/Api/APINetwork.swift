//
//  APINetwork.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/3.
//

import UIKit
import Alamofire

class APINetwork<T: Codable> {
    typealias ResponseType = T
        
    let apiDomain = "https://api.github.com"
    var method: HTTPMethod { return .get }
    var urlPath: String { return "" }
    var headers: HTTPHeaders { return [.authorization(bearerToken: getAuthorization())] }
    var parameters: [String: Any] = [:]
        
    func requestData(completionHandler: @escaping ((ResponseType?, String?) -> Void)) {
        let urlString = "\(apiDomain)\(urlPath)"
        AF.request(urlString, method: method, parameters: parameters, headers: headers).validate().response { requestData in
            switch requestData.result {
            case .success(let data):
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(ResponseType.self, from: data)
                        completionHandler(result, nil)
                    } catch {
                        completionHandler(nil, "Parse error: \(error)")
                    }
                }
            case .failure(_):
                let statusCode = requestData.response?.statusCode
                completionHandler(nil, String(format: "%d", statusCode ?? 0))
            }
        }
    }
    
    private func getAuthorization() -> String {
        let first = "MKxsFA66j4Sl0"
        let second = "OVduVql181c"
        let third = "IaRrq73GJhke"
        return "ghp_\(first)\(second)\(third)"
    }
}
