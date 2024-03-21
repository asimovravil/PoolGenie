//
//  AppDelegate.swift
//  PoolGenie
//
//  Created by Ravil on 21.03.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAppearance()
        return true
    }
    
    func setupAppearance() {
        print("setupAppearance")
    }
}
