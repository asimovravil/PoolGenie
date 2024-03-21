//
//  SceneDelegate.swift
//  PoolGenie
//
//  Created by Ravil on 21.03.2024.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupWindow(windowScene: windowScene)
    }
    
    func setupWindow(windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        window.overrideUserInterfaceStyle = .light
        
        let rootViewController: UIViewController
        if UserDefaults.standard.bool(forKey: "ass") {
            rootViewController = UINavigationController(rootViewController: PoolGenieCalculatorController())
        } else {
            rootViewController = UINavigationController(rootViewController: PoolGenieOnboController())
        }
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }
}
