//
//  APINetwork.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/3.
//

import UIKit
import Alamofire

let githubToken = "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"

class APINetwork<T: Codable> {
    typealias ResponseType = T
        
    let apiDomain = "https://api.github.com"
    var method: HTTPMethod { return .get }
    var urlPath: String { return "" }
    var headers: HTTPHeaders { return [.authorization(bearerToken: githubToken)] }
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
                completionHandler(nil, "Get data error: \(String(describing: statusCode))")
            }
        }
    }
}
