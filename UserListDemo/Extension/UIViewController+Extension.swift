//
//  UIViewController+Extension.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/4.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String? = nil, message: String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
