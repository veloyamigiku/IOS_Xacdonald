//
//  VCUtils.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/27.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class VCUtils: NSObject {
    
    private static func _createMenuViewControllerList() -> [CVPVCViewController] {
        var menuViewControllerIndex = 0
        var menuViewControllerList: [CVPVCViewController] = []
        for menuCategoryID in VCConstraint.MENU_CATEGORY_ID_LIST {
            let menuViewController = MenuViewController(
                categoryID: menuCategoryID,
                index: menuViewControllerIndex)
            menuViewControllerList.append(menuViewController)
            menuViewControllerIndex += 1
        }
        return menuViewControllerList
    }
    
    private static func _createMenuOrderViewControllerList() -> [CVPVCViewController] {
        var menuViewControllerIndex = 0
        var menuViewControllerList: [CVPVCViewController] = []
        for menuCategoryID in VCConstraint.MENU_CATEGORY_ID_LIST {
            let menuViewController = MenuOrderViewController(
                categoryID: menuCategoryID,
                index: menuViewControllerIndex)
            menuViewControllerList.append(menuViewController)
            menuViewControllerIndex += 1
        }
        return menuViewControllerList
    }
    
    private static func _createCVPVCViewControllerForMenu() -> CVPVCViewControllerA {
        let menuViewControllerList = _createMenuViewControllerList()
        let menuRootViewController = CVPVCViewControllerA(
            tabNameList: VCConstraint.MENU_CATEGORY_LIST,
            viewControllerList: menuViewControllerList)
        return menuRootViewController
    }
    
    static func createCVPVCViewControllerForMenu(title: String) -> CVPVCViewControllerA {
        let vc = _createCVPVCViewControllerForMenu()
        vc.title = title
        return vc
    }
    
    static func createCVPVCViewControlleForMenu() -> CVPVCViewControllerA {
        let vc = _createCVPVCViewControllerForMenu()
        NavigationItem.config(navigationItem: vc.navigationItem)
        return vc
    }
    
    static func createMenuOrderRootViewController(title: String) -> MenuOrderRootViewController {
        let menuViewControllerList = _createMenuOrderViewControllerList()
        let menuOrderRootViewController = MenuOrderRootViewController(
            tabNameList: VCConstraint.MENU_CATEGORY_LIST,
            viewControllerList: menuViewControllerList)
        menuOrderRootViewController.title = title
        return menuOrderRootViewController
    }
    
    static func createMenuOrderRootViewController(
        title: String,
        preOrderMenuItem: MenuItem) -> MenuOrderRootViewController {
        let menuViewControllerList = _createMenuOrderViewControllerList()
        let menuOrderRootViewController = MenuOrderRootViewController(
            tabNameList: VCConstraint.MENU_CATEGORY_LIST,
            viewControllerList: menuViewControllerList,
            preOrderMenuItem: preOrderMenuItem)
        menuOrderRootViewController.navigationItem.title = title
        return menuOrderRootViewController
    }
    
}
