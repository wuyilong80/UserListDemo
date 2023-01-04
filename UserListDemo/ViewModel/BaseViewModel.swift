//
//  BaseViewModel.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/4.
//

import UIKit

protocol BaseViewModelDelegate: AnyObject {
    func willLoadData()
    func didLoadData()
    func receiveError(code: String?)
}

class BaseViewModel: NSObject {

    weak var delegate: BaseViewModelDelegate?
    
    func loadData() {
        fatalError("Please override this method")
    }
}
