//
//  MenuCollectionReusableView.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/04/15.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class MenuCollectionReusableView: UICollectionReusableView {
    
    private static let LABEL_MARGIN_TOP = CGFloat(5)
    private static let LABEL_MARGIN_BOTTOM = CGFloat(5)
    static let HEIGHT = LABEL_MARGIN_TOP + "".heightOfString(font: UIFont.boldSystemFont(ofSize: 17)) + LABEL_MARGIN_BOTTOM
    
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        addSubview(label)
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: MenuCollectionReusableView.LABEL_MARGIN_TOP).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -MenuCollectionReusableView.LABEL_MARGIN_BOTTOM).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
