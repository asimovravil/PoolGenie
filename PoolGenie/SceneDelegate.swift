//
//  SceneDelegate.swift
//  PoolGenie
//
//  Created by Ravil on 21.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.overrideUserInterfaceStyle = .light
        window.rootViewController =
        UINavigationController(rootViewController: PoolGenieOnboController())
        window.makeKeyAndVisible()
        self.window = window
    }
}
