//
//  CVPVCCollectionViewCellB.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/16.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class CVPVCCollectionViewCellB: UICollectionViewCell {
    
    private static let LABEL_MARGIN_TOP_BOTTOM = CGFloat(5)
    static let LABEL_MARGIN_LEFT_RIGHT = CGFloat(5)
    static let LABEL_FONT_SIZE = CGFloat(13)
    static let CELL_HEIGHT = round(LABEL_MARGIN_TOP_BOTTOM + "".heightOfString(font: UIFont.systemFont(ofSize: LABEL_FONT_SIZE)) + LABEL_MARGIN_TOP_BOTTOM)
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        label.lineBreakMode = .byClipping
        label.font = UIFont.systemFont(ofSize: CVPVCCollectionViewCellB.LABEL_FONT_SIZE)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor, constant: CVPVCCollectionViewCellB.LABEL_MARGIN_TOP_BOTTOM).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CVPVCCollectionViewCellB.LABEL_MARGIN_LEFT_RIGHT).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CVPVCCollectionViewCellB.LABEL_MARGIN_LEFT_RIGHT).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CVPVCCollectionViewCellB.LABEL_MARGIN_TOP_BOTTOM).isActive = true
        
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
