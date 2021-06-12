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
    private var orderCountLabel: UILabel!
    private var orderPriceLabel: UILabel!
    
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
        
        orderCountLabel = UILabel()
        orderCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(orderCountLabel)
        orderCountLabel.topAnchor.constraint(equalTo: pageViewControllerBottomAnchor, constant: 5).isActive = true
        orderCountLabel.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 5).isActive = true
        orderCountLabel.bottomAnchor.constraint(equalTo: salg.bottomAnchor, constant: -5).isActive = true
        
        orderPriceLabel = UILabel()
        orderPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(orderPriceLabel)
        orderPriceLabel.topAnchor.constraint(equalTo: pageViewControllerBottomAnchor, constant: 5).isActive = true
        orderPriceLabel.leadingAnchor.constraint(equalTo: orderCountLabel.trailingAnchor, constant: 10).isActive = true
        orderPriceLabel.bottomAnchor.constraint(equalTo: salg.bottomAnchor, constant: -5).isActive = true
        
        let registerButton = UIButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setAttributedTitle(NSAttributedString(
                                            string: "レジに進む",
                                            attributes: [
                                                NSAttributedString.Key.foregroundColor: UIColor.black,
                                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)
                                            ]), for: .normal)
        registerButton.backgroundColor = UIColor.init(hex: "ffcc33")
        registerButton.layer.cornerRadius = 5
        registerButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.addSubview(registerButton)
        registerButton.topAnchor.constraint(equalTo: pageViewControllerBottomAnchor, constant: 5).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -5).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: salg.bottomAnchor, constant: -5).isActive = true
        
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
        let orderCountStr = NSMutableAttributedString()
        orderCountStr.append(NSAttributedString(
                                string: String(orderCount),
                                attributes: [
                                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26)]))
        orderCountStr.append(NSAttributedString(
                                string: "点",
                                attributes: [
                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
        orderCountLabel.attributedText = orderCountStr
        
        let orderPrice = calcOrderPrice()
        let orderPriceStr = NSMutableAttributedString()
        orderPriceStr.append(NSAttributedString(
                                string: "¥",
                                attributes: [
                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
        orderPriceStr.append(NSAttributedString(
                                string: Formatter.formatForPrice(number: orderPrice),
                                attributes: [
                                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26)]))
        orderPriceLabel.attributedText = orderPriceStr
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
