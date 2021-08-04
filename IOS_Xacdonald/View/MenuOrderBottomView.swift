//
//  MenuOrderBottomView.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/06/12.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class MenuOrderBottomView: UIView, UITableViewDataSource {
    
    private static let LABEL_FONT_SIZE: CGFloat = 18
    
    private static let LABEL_LARGE_FONT_SIZE: CGFloat = 26
    
    private static let LABEL_TOP_BOTTOM_MARGIN: CGFloat = 5
    
    private static let BUTTON_FONT_SIZE: CGFloat = 13
    
    private static let BUTTON_TOP_BOTTOM_MARGIN: CGFloat = 5
    
    private static let BUTTON_INSETS: CGFloat = 10
    
    private static let LABEL_HEIGHT_WITH_MARGIN: CGFloat =
        LABEL_TOP_BOTTOM_MARGIN +
        "".heightOfString(font: UIFont.boldSystemFont(ofSize: LABEL_LARGE_FONT_SIZE)) +
        LABEL_TOP_BOTTOM_MARGIN
    
    private static let BUTTON_HEIGHT_WITH_MARGIN: CGFloat =
        BUTTON_TOP_BOTTOM_MARGIN +
        BUTTON_INSETS +
        "".heightOfString(font: UIFont.systemFont(ofSize: BUTTON_FONT_SIZE)) +
        BUTTON_INSETS +
        BUTTON_TOP_BOTTOM_MARGIN
    
    static let CLOSE_HEIGHT: CGFloat = LABEL_HEIGHT_WITH_MARGIN > BUTTON_HEIGHT_WITH_MARGIN ? LABEL_HEIGHT_WITH_MARGIN : BUTTON_HEIGHT_WITH_MARGIN
    
    private var tableView: UITableView!
    
    private var orderCountLabel: UILabel!
    
    private var orderPriceLabel: UILabel!
    
    private var orderMenuItemList: [MenuItem]!
    
    private var isOpen: Bool!
    
    private var openTableViewHeightConstraint: NSLayoutConstraint!
    
    private var closeTableViewHeightConstraint: NSLayoutConstraint!
    
    private func calcOpenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.size.height
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height
        return (screenHeight - statusBarHeight!) * 0.3
    }
    
    override func layoutSubviews() {
        let openHeight = calcOpenHeight()
        if openTableViewHeightConstraint == nil {
            openTableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: openHeight)
        } else {
            openTableViewHeightConstraint.constant = openHeight
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.orderMenuItemList = []
        
        self.isOpen = false
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            MenuOrderBottomTableViewCell.self,
            forCellReuseIdentifier: "MenuOrderBottomTableViewCell")
        tableView.dataSource = self
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        containerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        orderCountLabel = UILabel()
        orderCountLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(orderCountLabel)
        orderCountLabel.topAnchor.constraint(
            equalTo: containerView.topAnchor,
            constant: 0).isActive = true
        orderCountLabel.leadingAnchor.constraint(
            equalTo: containerView.leadingAnchor,
            constant: MenuOrderBottomView.LABEL_TOP_BOTTOM_MARGIN).isActive = true
        orderCountLabel.bottomAnchor.constraint(
            equalTo: containerView.bottomAnchor,
            constant: -MenuOrderBottomView.LABEL_TOP_BOTTOM_MARGIN).isActive = true
        
        orderPriceLabel = UILabel()
        orderPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(orderPriceLabel)
        orderPriceLabel.topAnchor.constraint(
            equalTo: containerView.topAnchor,
            constant: MenuOrderBottomView.LABEL_TOP_BOTTOM_MARGIN).isActive = true
        orderPriceLabel.leadingAnchor.constraint(
            equalTo: orderCountLabel.trailingAnchor,
            constant: 10).isActive = true
        orderPriceLabel.bottomAnchor.constraint(
            equalTo: containerView.bottomAnchor,
            constant: -MenuOrderBottomView.LABEL_TOP_BOTTOM_MARGIN).isActive = true
        
        let registerButton = UIButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setAttributedTitle(NSAttributedString(
                                            string: "レジに進む",
                                            attributes: [
                                                NSAttributedString.Key.foregroundColor:
                                                    UIColor.black,
                                                NSAttributedString.Key.font:
                                                    UIFont.systemFont(ofSize: MenuOrderBottomView.BUTTON_FONT_SIZE)
                                            ]), for: .normal)
        registerButton.backgroundColor = UIColor.init(hex: "ffcc33")
        registerButton.layer.cornerRadius = 5
        registerButton.contentEdgeInsets = UIEdgeInsets(
            top: MenuOrderBottomView.BUTTON_INSETS,
            left: MenuOrderBottomView.BUTTON_INSETS,
            bottom: MenuOrderBottomView.BUTTON_INSETS,
            right: MenuOrderBottomView.BUTTON_INSETS)
        containerView.addSubview(registerButton)
        registerButton.topAnchor.constraint(
            equalTo: containerView.topAnchor,
            constant: MenuOrderBottomView.BUTTON_TOP_BOTTOM_MARGIN).isActive = true
        registerButton.trailingAnchor.constraint(
            equalTo: containerView.trailingAnchor,
            constant: -5).isActive = true
        registerButton.bottomAnchor.constraint(
            equalTo: containerView.bottomAnchor,
            constant: -MenuOrderBottomView.BUTTON_TOP_BOTTOM_MARGIN).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addOrderMenuItem(menuItem: MenuItem) {
        orderMenuItemList.append(menuItem)
        print("add order menu Item.")
        updateOrderMenu()
    }
    
    func updateOrderMenu() {
        updateOrderCount(orderCount: orderMenuItemList.count)
        updateOrderPrice(orderPrice: calcOrderPrice())
        tableView.reloadData()
    }
    
    func getOrderCount() -> Int {
        return orderMenuItemList.count
    }
    
    private func calcOrderPrice() -> Int {
        var orderPrice = 0
        for orderMenuItem in orderMenuItemList {
            orderPrice += orderMenuItem.price
        }
        return orderPrice
    }
    
    private func updateOrderCount(orderCount: Int) {
        let orderCountStr = NSMutableAttributedString()
        orderCountStr.append(NSAttributedString(
                                string: String(orderCount),
                                attributes: [
                                    NSAttributedString.Key.font:
                                        UIFont.boldSystemFont(ofSize: MenuOrderBottomView.LABEL_LARGE_FONT_SIZE)]))
        orderCountStr.append(NSAttributedString(
                                string: "点",
                                attributes: [
                                    NSAttributedString.Key.font:
                                        UIFont.systemFont(ofSize: MenuOrderBottomView.LABEL_FONT_SIZE)]))
        orderCountLabel.attributedText = orderCountStr
    }
    
    private func updateOrderPrice(orderPrice: Int) {
        let orderPriceStr = NSMutableAttributedString()
        orderPriceStr.append(NSAttributedString(
                                string: "¥",
                                attributes: [
                                    NSAttributedString.Key.font:
                                        UIFont.systemFont(ofSize: MenuOrderBottomView.LABEL_FONT_SIZE)]))
        orderPriceStr.append(NSAttributedString(
                                string: Formatter.formatForPrice(number: orderPrice),
                                attributes: [
                                    NSAttributedString.Key.font:
                                        UIFont.boldSystemFont(ofSize: MenuOrderBottomView.LABEL_LARGE_FONT_SIZE)]))
        orderPriceLabel.attributedText = orderPriceStr
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderMenuItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOrderBottomTableViewCell", for: indexPath) as! MenuOrderBottomTableViewCell
        cell.nameLabel.text = orderMenuItemList[indexPath.row].name
        return cell
    }
    
}
