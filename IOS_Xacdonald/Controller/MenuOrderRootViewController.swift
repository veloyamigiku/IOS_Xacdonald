//
//  MenuOrderRootViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/28.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class MenuOrderRootViewController: CVPVCViewControllerA {
    
    private var preOrderMenuItem: MenuItem!
    private var orderMenuItemList: [MenuItem]!
    
    override init(
        tabNameList: [String],
        viewControllerList: [CVPVCViewController]) {
        super.init(tabNameList: tabNameList, viewControllerList: viewControllerList)
        orderMenuItemList = []
    }
    
    init(
        tabNameList: [String],
        viewControllerList: [CVPVCViewController],
        preOrderMenuItem: MenuItem) {
        super.init(tabNameList: tabNameList, viewControllerList: viewControllerList)
        self.preOrderMenuItem = preOrderMenuItem
        orderMenuItemList = []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (preOrderMenuItem != nil) {
            self.navigationController?.pushViewController(
                MenuOrderDetailViewController(menuItem: preOrderMenuItem),
                animated: true)
        }
    }
    
    func addOrderMenuItem(menuItem: MenuItem) {
        orderMenuItemList.append(menuItem)
        print("add order menu Item.")
    }
    
}
