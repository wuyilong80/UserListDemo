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
    private var maxCount: Int
    private var isLoadCompleted: Bool {
        return userInfoList.count >= maxCount
    }
    
    var reloadIndexPaths: [IndexPath] = []
    var userInfoList: [UserInfo] = []
    
    //MARK: - Initialize
    init(sinceId: Int, perPage: Int, max: Int) {
        self.sinceId = sinceId
        self.perPage = perPage
        self.maxCount = max
    }
    
    //MARK: - Method
    override func loadData() {
        delegate?.willLoadData()
        UsersAPI(sinceId: sinceId, perPage: perPage).requestData { userInfos, errorCode in
            if let userInfos = userInfos {
                self.parseResponseData(list: userInfos)
                self.delegate?.didLoadData()
            } else {
                self.reloadIndexPaths = []
                let message = ErrorHandler(errorCode: errorCode).handler()
                self.delegate?.receiveError(message: message)
            }
        }
    }
    
    func loadMoreData() {
        if let info = userInfoList.last, let id = info.id, !isLoadCompleted {
            sinceId = id
            loadData()
        } else {
            reloadIndexPaths = []
            delegate?.didLoadData()
        }
    }
    
    private func parseResponseData(list: [UserInfo]) {
        if !list.isEmpty {
            reloadIndexPaths = []
            for index in userInfoList.count ..< userInfoList.count + list.count {
                reloadIndexPaths.append(IndexPath(item: index, section: 0))
            }
            userInfoList += list
        }
    }
}
