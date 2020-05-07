//
//  MainTabBar.swift
//  Quickr
//
//  Created by Anshul Garg on 05/05/20.
//  Copyright © 2020 Anshul Garg. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor(red: 0/255.0, green: 146/255.0, blue: 248/255.0, alpha: 1.0)
        view.backgroundColor = .white
        createTabBar()
        // Do any additional setup after loading the view.
    }
    
    func createTabBar(){
        let firstTabNavigationController = HomeViewController()
        let secondTabNavigationControoller = SellViewController()
        let thirdTabNavigationController =  MyAdsViewController()
        let controllerArray = [firstTabNavigationController, secondTabNavigationControoller, thirdTabNavigationController]
        viewControllers = controllerArray.map{ UINavigationController.init(rootViewController: $0)}
        
        
        let item1 = UITabBarItem(title: "Home", image: UIImage(systemName: "cart" ), tag: 0)
        let item2 = UITabBarItem(title: "Sell", image: UIImage(named:  "sign"), tag: 1)
        let item3 = UITabBarItem(title: "MyAds", image: UIImage(systemName: "folder.circle.fill"), tag: 2)
        
        firstTabNavigationController.tabBarItem = item1
        secondTabNavigationControoller.tabBarItem = item2
        thirdTabNavigationController.tabBarItem = item3
    }
    
    
}
