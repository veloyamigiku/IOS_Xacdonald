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
        ModelConstant.CATEGORY_PS5,
        ModelConstant.CATEGORY_XBOX_SERIES_X_S,
        ModelConstant.CATEGORY_PS4,
        ModelConstant.CATEGORY_XBOX_ONE,
        ModelConstant.CATEGORY_SW,
        ModelConstant.CATEGORY_PS3
    ]
    
    private static let COUPON_CATEGORY_ID_LIST = [
        ModelConstant.CATEGORY_ID_PS5,
        ModelConstant.CATEGORY_ID_XBOX_SERIES_X_S,
        ModelConstant.CATEGORY_ID_PS4,
        ModelConstant.CATEGORY_ID_XBOX_ONE,
        ModelConstant.CATEGORY_ID_SW,
        ModelConstant.CATEGORY_ID_PS3
    ]
    
    private static let MENU_CATEGORY_LIST = [
        ModelConstant.CATEGORY_PS5,
        ModelConstant.CATEGORY_XBOX_SERIES_X_S,
        ModelConstant.CATEGORY_PS4,
        ModelConstant.CATEGORY_XBOX_ONE,
        ModelConstant.CATEGORY_SW,
        ModelConstant.CATEGORY_PS3
    ]
    
    private static let MENU_LIST: [Menu] = [
        Menu(
            id: ModelConstant.CATEGORY_ID_PS5,
            keywordList: [
                ModelConstant.GENRE_ACTION,
                ModelConstant.GENRE_FPS,
                ModelConstant.GENRE_RPG,
                ModelConstant.GENRE_ADVENTURE,
                ModelConstant.GENRE_SHOOTING]),
        Menu(
            id: ModelConstant.CATEGORY_ID_XBOX_SERIES_X_S,
            keywordList: [
                ModelConstant.GENRE_ACTION,
                ModelConstant.GENRE_FPS,
                ModelConstant.GENRE_RPG,
                ModelConstant.GENRE_ADVENTURE,
                ModelConstant.GENRE_SHOOTING]),
        Menu(
            id: ModelConstant.CATEGORY_ID_PS4,
            keywordList: [
                ModelConstant.GENRE_ACTION,
                ModelConstant.GENRE_FPS,
                ModelConstant.GENRE_RPG,
                ModelConstant.GENRE_ADVENTURE,
                ModelConstant.GENRE_SHOOTING]),
        Menu(
            id: ModelConstant.CATEGORY_ID_XBOX_ONE,
            keywordList: [
                ModelConstant.GENRE_ACTION,
                ModelConstant.GENRE_FPS,
                ModelConstant.GENRE_RPG,
                ModelConstant.GENRE_ADVENTURE,
                ModelConstant.GENRE_SHOOTING]),
        Menu(
            id: ModelConstant.CATEGORY_ID_SW,
            keywordList: [
                ModelConstant.GENRE_ACTION,
                ModelConstant.GENRE_FPS,
                ModelConstant.GENRE_RPG,
                ModelConstant.GENRE_ADVENTURE,
                ModelConstant.GENRE_SHOOTING]),
        Menu(
            id: ModelConstant.CATEGORY_ID_PS3,
            keywordList: [
                ModelConstant.GENRE_ACTION,
                ModelConstant.GENRE_FPS,
                ModelConstant.GENRE_RPG,
                ModelConstant.GENRE_ADVENTURE,
                ModelConstant.GENRE_SHOOTING])
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
        var couponViewControllerList: [CVPVCViewController] = []
        for couponCategoryID in MainTabBarController.COUPON_CATEGORY_ID_LIST {
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
        
        var menuViewControllerIndex = 0
        var menuViewControllerList: [CVPVCViewController] = []
        for menu in MainTabBarController.MENU_LIST {
            let menuViewController = MenuViewController(menu: menu, index: menuViewControllerIndex)
            menuViewControllerList.append(menuViewController)
            menuViewControllerIndex += 1
        }
        let menuRootViewController = CollectionViewPageViewController(
            tabNameList: MainTabBarController.MENU_CATEGORY_LIST,
            viewControllerList: menuViewControllerList)
        let menuNavigationController = UINavigationController()
        menuNavigationController.viewControllers = [menuRootViewController]
        menuNavigationController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "menu_active")?.withRenderingMode(.alwaysOriginal))
        
        viewControllers = [
            homeNavigationViewController,
            couponNavigationController,
            menuNavigationController
        ]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
}
