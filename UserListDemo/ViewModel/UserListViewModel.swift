//
//  UserListViewModel.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/4.
//

import UIKit


class UserListViewModel: BaseViewModel {

    private var sinceId: Int
    private var perPage: Int
    
    var userInfoList: [UserInfo] = []
    var isLoadCompleted: Bool = false
    
    init(sinceId: Int, perPage: Int) {
        self.sinceId = sinceId
        self.perPage = perPage
    }
    
    override func loadData() {
        delegate?.willLoadData()
        UsersAPI(sinceId: sinceId, perPage: perPage).requestData { userInfos, errorCode in
            if let userInfos = userInfos {
                self.parseResponseData(list: userInfos)
                self.delegate?.didLoadData()
            } else {
                self.delegate?.receiveError(code: errorCode)
            }
        }
    }
    
    func loadMoreData() {
        if let info = userInfoList.last, let id = info.id, !isLoadCompleted {
            sinceId = id
            loadData()
        } else {
            delegate?.didLoadData()
        }
    }
    
    func parseResponseData(list: [UserInfo]) {
        if list.isEmpty {
            isLoadCompleted = true
        } else {
            self.userInfoList += list
        }
    }
}
