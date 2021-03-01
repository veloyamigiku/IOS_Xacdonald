//
//  RecommendedItemView.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/02/18.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit
import PINRemoteImage

class RecommendedItemView: UIView {
    
    private var itemImage: UIImageView!
    private var nameLabel: UILabel!
    private var priceLabel: UILabel!
    
    var recommendedItem: RecommendedItem! {
        didSet {
            guard let ri = recommendedItem else { return }
            itemImage.pin_setImage(from: URL(string: ri.imageUrl))
            nameLabel.text = ri.name
            priceLabel.text = "¥" + String(ri.price)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        itemImage = UIImageView()
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(itemImage)
        itemImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        itemImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        itemImage.heightAnchor.constraint(equalToConstant: 106).isActive = true
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        
        priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(priceLabel)
        priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
