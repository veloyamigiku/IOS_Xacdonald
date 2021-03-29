//
//  CouponDetailView.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/03/21.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class CouponDetailView: UIView {
    
    init(frame: CGRect, couponItem: CouponItem) {
        super.init(frame: frame)
        
        let salg = safeAreaLayoutGuide
        
        backgroundColor = .white
        
        let topBorder = UIView()
        topBorder.backgroundColor = .orange
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topBorder)
        topBorder.widthAnchor.constraint(equalTo: salg.widthAnchor).isActive = true
        topBorder.heightAnchor.constraint(equalToConstant: 10).isActive = true
        topBorder.topAnchor.constraint(equalTo: salg.topAnchor).isActive = true
        topBorder.leadingAnchor.constraint(equalTo: salg.leadingAnchor).isActive = true
        topBorder.trailingAnchor.constraint(equalTo: salg.trailingAnchor).isActive = true
        
        let nameLabel = UILabel()
        nameLabel.text = couponItem.name
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: topBorder.bottomAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -10).isActive = true
        
        let infoLabel = UILabel()
        infoLabel.text =
            "※表記している商品・サイズのみ有効です。\n" +
            "※税込価格での表示です。\n" +
            "※店頭価格は店舗によって異なります。"
        infoLabel.font = UIFont.systemFont(ofSize: 15)
        infoLabel.numberOfLines = 0
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(infoLabel)
        infoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 10).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -10).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: salg.bottomAnchor, constant: -20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
