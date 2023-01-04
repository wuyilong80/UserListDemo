//
//  UserDetailViewModel.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/4.
//

import UIKit

class UserDetailViewModel: BaseViewModel {

    private var userName: String
    
    var userInfo: UserInfo?
    
    //MARK: - Initialize
    init(username: String) {
        self.userName = username
    }
    
    //MARK: - Method
    override func loadData() {
        delegate?.willLoadData()
        UserAPI(userName: userName).requestData { info, errorCode in
            if let info = info {
                self.userInfo = info
                self.delegate?.didLoadData()
            } else {
                let message = ErrorHandler(errorCode: errorCode).handler()
                self.delegate?.receiveError(message: message)
            }
        }
    }
}
