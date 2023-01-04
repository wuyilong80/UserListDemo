//
//  UIView+extension.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/3.
//

import Foundation
import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 3
    }
}
