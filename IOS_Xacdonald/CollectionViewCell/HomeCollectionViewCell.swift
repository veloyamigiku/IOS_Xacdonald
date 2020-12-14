//
//  HomeCollectionViewCell.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2020/12/14.
//  Copyright © 2020 velo.yamigiku. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 10
        
    }
    
}
