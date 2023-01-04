//
//  AppDelegate.swift
//  UserListDemo
//
//  Created by Lawrence on 2023/1/3.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupRootVC()
        
        return true
    }
    
    func setupRootVC() {
        guard let window = window else { return }        
        let vc = UserListViewController(viewModel: UserListViewModel(sinceId: 0, perPage: 10, max: 100))
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}

