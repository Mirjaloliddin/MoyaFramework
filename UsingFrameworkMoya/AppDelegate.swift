//
//  AppDelegate.swift
//  UsingFrameworkMoya
//
//  Created by Murtazaev Mirjaloliddin Kamolovich on 14/09/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let viewController = UINavigationController(rootViewController: UserViewController())
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

