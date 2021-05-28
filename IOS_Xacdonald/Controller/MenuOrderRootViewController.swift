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
    
    override init(
        tabNameList: [String],
        viewControllerList: [CVPVCViewController]) {
        super.init(tabNameList: tabNameList, viewControllerList: viewControllerList)
    }
    
    init(
        tabNameList: [String],
        viewControllerList: [CVPVCViewController],
        preOrderMenuItem: MenuItem) {
        super.init(tabNameList: tabNameList, viewControllerList: viewControllerList)
        self.preOrderMenuItem = preOrderMenuItem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (preOrderMenuItem != nil) {
            self.navigationController?.pushViewController(
                MenuOrderViewController(menuItem: preOrderMenuItem),
                animated: true)
        }
    }
}
