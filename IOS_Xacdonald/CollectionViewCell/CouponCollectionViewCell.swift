//
//  CouponCollectionViewCell.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/03/15.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class CouponCollectionViewCell: UICollectionViewCell {
    
    private static let LABEL_MARGIN_TOP = CGFloat(5)
    private static let INDICATOR_VIEW_MARGIN_TOP = CGFloat(5)
    private static let INDICATOR_VIEW_HEIGHT = CGFloat(5)
    static let CELL_HEIGHT = LABEL_MARGIN_TOP + "".heightOfString(font: UIFont.systemFont(ofSize: 17)) + INDICATOR_VIEW_MARGIN_TOP + INDICATOR_VIEW_HEIGHT
    var label: UILabel!
    var indicatorView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        label.lineBreakMode = .byClipping
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor, constant: CouponCollectionViewCell.LABEL_MARGIN_TOP).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        indicatorView = UIView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicatorView)
        indicatorView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: CouponCollectionViewCell.INDICATOR_VIEW_MARGIN_TOP).isActive = true
        indicatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        indicatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: CouponCollectionViewCell.INDICATOR_VIEW_HEIGHT).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            let color = isSelected ? UIColor.red : UIColor.black
            label.textColor = color
            indicatorView.backgroundColor = isSelected ? UIColor.red : UIColor.clear
        }
    }
}
