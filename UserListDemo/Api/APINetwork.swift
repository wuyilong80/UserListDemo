//
//  APINetwork.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/3.
//

import UIKit
import Alamofire

let githubToken =  "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"

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
                completionHandler(nil, "\(String(describing: statusCode))")
            }
        }
    }
    
//    private func parseToken() -> String {
//        let strList = githubToken.components(separatedBy: "#")
//        return "\(strList[0])\(strList[1])"
//    }
}
