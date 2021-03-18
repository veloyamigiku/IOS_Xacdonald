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
        let homeNavigationViewController = UINavigationController()
        homeNavigationViewController.viewControllers = [homeViewController]
        homeNavigationViewController.tabBarItem = UITabBarItem(
                title: "",
                image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal),
                selectedImage: UIImage(named: "home_active")?.withRenderingMode(.alwaysOriginal))

        let couponRootViewController = CouponRootViewController()
        let couponNavigationController = UINavigationController()
        couponNavigationController.viewControllers = [couponRootViewController]
        couponNavigationController.tabBarItem = UITabBarItem(
                title: "",
                image: UIImage(named: "coupon")?.withRenderingMode(.alwaysOriginal),
                selectedImage: UIImage(named: "coupon_active")?.withRenderingMode(.alwaysOriginal))
        
        viewControllers = [homeNavigationViewController, couponNavigationController]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
}
