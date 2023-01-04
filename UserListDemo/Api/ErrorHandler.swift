//
//  ErrorHandler.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/4.
//

import UIKit

class ErrorHandler: NSObject {
    
    enum APIErrorCode: String {
        case authErrorCode = "401"
        case domainErrorCode = "404"
    }

    private var currentCode: String?
    
    init(errorCode: String?) {
        super.init()
        self.currentCode = errorCode
    }
    
    func handler() -> String {
        if let parseError = currentCode?.contains("Parse error:"), parseError {
            return currentCode ?? ""
        }
        
        switch APIErrorCode(rawValue: currentCode ?? "") {
        case .authErrorCode:
            return "ERROR: bad credentials."
        case .domainErrorCode:
            return "ERROR: not found."
        default:
            return "ERROR: unknown error."
        }
    }
}
