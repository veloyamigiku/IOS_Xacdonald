//
//  MenuOrderBottomView.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/06/12.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class MenuOrderBottomView: UIView {
    
    private var orderCountLabel: UILabel!
    
    private var orderPriceLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let salg = safeAreaLayoutGuide
        
        orderCountLabel = UILabel()
        orderCountLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(orderCountLabel)
        orderCountLabel.topAnchor.constraint(equalTo: salg.topAnchor, constant: 5).isActive = true
        orderCountLabel.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 5).isActive = true
        orderCountLabel.bottomAnchor.constraint(equalTo: salg.bottomAnchor, constant: -5).isActive = true
        
        orderPriceLabel = UILabel()
        orderPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(orderPriceLabel)
        orderPriceLabel.topAnchor.constraint(equalTo: salg.topAnchor, constant: 5).isActive = true
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
        addSubview(registerButton)
        registerButton.topAnchor.constraint(equalTo: salg.topAnchor, constant: 5).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -5).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: salg.bottomAnchor, constant: -5).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateOrderCount(orderCount: Int) {
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
    }
    
    func updateOrderPrice(orderPrice: Int) {
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
    
}
