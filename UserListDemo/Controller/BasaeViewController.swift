//
//  BasaeViewController.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/4.
//

import UIKit

class BasaeViewController: UIViewController {

    lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.isHidden = true
        return indicator
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateIndicatorStatus(isHidden: Bool) {
        indicatorView.isHidden = isHidden
        if isHidden {
            indicatorView.stopAnimating()
        } else {
            indicatorView.startAnimating()
        }
    }
}
