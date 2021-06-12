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
    private var menuOrderBottomView: MenuOrderBottomView!
    
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
        
        let salg = view.safeAreaLayoutGuide
        
        pageViewControllerBottomConstraint.isActive = false
        
        menuOrderBottomView = MenuOrderBottomView()
        menuOrderBottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuOrderBottomView)
        menuOrderBottomView.topAnchor.constraint(equalTo: pageViewControllerBottomAnchor, constant: 5).isActive = true
        menuOrderBottomView.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 5).isActive = true
        menuOrderBottomView.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -5).isActive = true
        menuOrderBottomView.bottomAnchor.constraint(equalTo: salg.bottomAnchor, constant: -5).isActive = true
        
        if (preOrderMenuItem != nil) {
            self.navigationController?.pushViewController(
                MenuOrderDetailViewController(menuItem: preOrderMenuItem),
                animated: true)
        }
    }
    
    func addOrderMenuItem(menuItem: MenuItem) {
        orderMenuItemList.append(menuItem)
        print("add order menu Item.")
        updateOrderMenu()
    }
    
    private func updateOrderMenu() {
        let orderCount = getOrderCount()
        menuOrderBottomView.updateOrderCount(orderCount: orderCount)
        
        let orderPrice = calcOrderPrice()
        menuOrderBottomView.updateOrderPrice(orderPrice: orderPrice)
    }
    
    private func getOrderCount() -> Int {
        return orderMenuItemList.count
    }
    
    private func calcOrderPrice() -> Int {
        var orderPrice = 0
        for orderMenuItem in orderMenuItemList {
            orderPrice += orderMenuItem.price
        }
        return orderPrice
    }
    
}
