//
//  CVPVCCollectionViewCellA.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/16.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class CVPVCCollectionViewCellA: UICollectionViewCell {
    
    private static let LABEL_MARGIN_TOP = CGFloat(5)
    static let LABEL_MARGIN_LEFT_RIGHT = CGFloat(5)
    static let LABEL_FONT_SIZE = CGFloat(13)
    private static let INDICATOR_VIEW_MARGIN_TOP = CGFloat(5)
    private static let INDICATOR_VIEW_HEIGHT = CGFloat(5)
    static let CELL_HEIGHT = round(LABEL_MARGIN_TOP + "".heightOfString(font: UIFont.systemFont(ofSize: LABEL_FONT_SIZE)) + INDICATOR_VIEW_MARGIN_TOP + INDICATOR_VIEW_HEIGHT)
    var label: UILabel!
    var indicatorView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        label.lineBreakMode = .byClipping
        label.font = UIFont.systemFont(ofSize: CVPVCCollectionViewCellA.LABEL_FONT_SIZE)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor, constant: CVPVCCollectionViewCellA.LABEL_MARGIN_TOP).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CVPVCCollectionViewCellA.LABEL_MARGIN_LEFT_RIGHT).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CVPVCCollectionViewCellA.LABEL_MARGIN_LEFT_RIGHT).isActive = true
        
        indicatorView = UIView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicatorView)
        indicatorView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: CVPVCCollectionViewCellA.INDICATOR_VIEW_MARGIN_TOP).isActive = true
        indicatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        indicatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: CVPVCCollectionViewCellA.INDICATOR_VIEW_HEIGHT).isActive = true
        
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
