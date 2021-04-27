//
//  MenuCollectionViewCell.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/04/15.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    private static let IMAGE_MARGIN_TOP = CGFloat(5)
    private static let IMAGE_HEIGHT = CGFloat(106)
    private static let NAME_LABEL_MARGIN_TOP = CGFloat(5)
    private static let PRICE_VALUE_LABEL_MARGIN_TOP = CGFloat(5)
    private static let PRICE_VALUE_LABEL_MARGIN_BOTTOM = CGFloat(5)
    static let HEIGHT =
        IMAGE_MARGIN_TOP +
        IMAGE_HEIGHT +
        NAME_LABEL_MARGIN_TOP +
        "\n\n".heightOfString(font: UIFont.systemFont(ofSize: 12)) +
        PRICE_VALUE_LABEL_MARGIN_TOP +
        "\n".heightOfString(font: UIFont.boldSystemFont(ofSize: 14)) +
        PRICE_VALUE_LABEL_MARGIN_BOTTOM
    
    var image: UIImageView!
    var nameLabel: UILabel!
    var priceLabel: UILabel!
    var priceValueLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3
        
        image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: MenuCollectionViewCell.IMAGE_MARGIN_TOP).isActive = true
        image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: MenuCollectionViewCell.IMAGE_HEIGHT).isActive = true
        image.heightAnchor.constraint(equalToConstant: MenuCollectionViewCell.IMAGE_HEIGHT).isActive = true
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.numberOfLines = 3
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: MenuCollectionViewCell.NAME_LABEL_MARGIN_TOP).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        
        priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.boldSystemFont(ofSize: 10)
        addSubview(priceLabel)
        
        priceValueLabel = UILabel()
        priceValueLabel.translatesAutoresizingMaskIntoConstraints = false
        priceValueLabel.font = UIFont.boldSystemFont(ofSize: 14)
        addSubview(priceValueLabel)
        priceValueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: MenuCollectionViewCell.PRICE_VALUE_LABEL_MARGIN_TOP).isActive = true
        priceValueLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 1).isActive = true
        priceValueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -MenuCollectionViewCell.PRICE_VALUE_LABEL_MARGIN_BOTTOM).isActive = true
        
        //priceLabel.topAnchor.constraint(equalTo: priceValueLabel.topAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: priceValueLabel.bottomAnchor, constant: -1).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
