//
//  CouponCollectionViewCell.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/03/15.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class CouponCollectionViewCell: UICollectionViewCell {
    
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        label.lineBreakMode = .byClipping
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            let color = isSelected ? UIColor.red : UIColor.black
            label.textColor = color
        }
    }
}
