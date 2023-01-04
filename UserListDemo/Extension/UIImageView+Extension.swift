//
//  UIImageView+Extension.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/4.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func getImage(urlString: String?, radius: CGFloat? = nil) {
        guard let urlString = urlString else { return }
        let url = URL(string: urlString)
        SDWebImageManager.shared.loadImage(with: url, progress: nil) { image, _, _, _, _, _ in
            DispatchQueue.main.async {
                self.image = image
                if let radius = radius {
                    self.layer.cornerRadius = radius
                    self.layer.masksToBounds = true
                }
            }
        }
    }
}
