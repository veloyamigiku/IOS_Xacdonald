//
//  MainTabBarController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/03/02.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private static let COUPON_CATEGORY_LIST = [
        "PS5",
        "XBox Series X/S",
        "PS4",
        "XBox One",
        "Nintendo Switch",
        "PS3",
    ]
    
    private static let COUPON_CATEGORY_ID_LIST = [
        ModelConstant.CATEGORY_ID_PS5,
        ModelConstant.CATEGORY_ID_XBOX_SERIES_X_S,
        ModelConstant.CATEGORY_ID_PS4,
        ModelConstant.CATEGORY_ID_XBOX_ONE,
        ModelConstant.CATEGORY_ID_SW,
        ModelConstant.CATEGORY_ID_PS3
    ]
    
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

        var couponViewControllerIndex = 0
        var couponViewControllerList: [UIViewController] = []
        for couponCategoryID in MainTabBarController.COUPON_CATEGORY_ID_LIST {
            print(couponCategoryID)
            let couponViewController = CouponViewController(
                couponCategoryID: couponCategoryID,
                index: couponViewControllerIndex)
            couponViewControllerList.append(couponViewController)
            couponViewControllerIndex = couponViewControllerIndex + 1
        }
        let couponRootViewController = CollectionViewPageViewController(
            tabNameList: MainTabBarController.COUPON_CATEGORY_LIST,
            viewControllerList: couponViewControllerList)
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
