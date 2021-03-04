//
//  MainTabBarController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/03/02.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        
        let couponPageViewController = CouponPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil)
        couponPageViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        
        viewControllers = [homeViewController, couponPageViewController]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
}
