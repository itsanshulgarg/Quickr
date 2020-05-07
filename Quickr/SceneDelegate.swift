//
//  SceneDelegate.swift
//  Quickr
//
//  Created by Anshul Garg on 03/05/20.
//  Copyright © 2020 Anshul Garg. All rights reserved.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var navController: UINavigationController?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        navController = UINavigationController()
        if Auth.auth().currentUser != nil{
            let viewController: UIViewController = MainTabBar()
            self.navController!.pushViewController(viewController, animated: false)
            window = UIWindow(windowScene: winScene)
            self.navController?.navigationBar.isHidden = true
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
        }
        else{
            let viewController: UIViewController = LoginViewController()
            self.navController!.pushViewController(viewController, animated: false)
            window = UIWindow(windowScene: winScene)
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
        }
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

