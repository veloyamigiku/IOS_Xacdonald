//
//  ShopCollectionViewCell.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/08/17.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {
    
    static let STATE_LABEL_FONT_SIZE = CGFloat(12)
    
    private static let DIST_LABEL_MARGIN_TOP = CGFloat(5)
    static let DIST_LABEL_FONT_SIZE = CGFloat(12)
    private static let DIST_LABEL_HEIGHT = "".heightOfString(font: UIFont.boldSystemFont(ofSize: DIST_LABEL_FONT_SIZE))
    
    private static let NAME_LABEL_MARGIN_TOP = CGFloat(5)
    static let NAME_LABEL_FONT_SIZE = CGFloat(14)
    private static let NAME_LABEL_HEIGHT = "".heightOfString(font: UIFont.boldSystemFont(ofSize: NAME_LABEL_FONT_SIZE))
    
    private static let ADDRESS_LABEL_MARGIN_TOP = CGFloat(5)
    static let ADDRESS_LABEL_FONT_SIZE = CGFloat(12)
    private static let ADDRESS_LABEL_HEIGHT = "".heightOfString(font: UIFont.boldSystemFont(ofSize: ADDRESS_LABEL_FONT_SIZE))
    
    private static let STATION_LABEL_MARGIN_TOP = CGFloat(5)
    static let STATION_LABEL_FONT_SIZE = CGFloat(12)
    private static let STATION_LABEL_HEIGHT = "".heightOfString(font: UIFont.boldSystemFont(ofSize: STATION_LABEL_FONT_SIZE))
    
    private static let RAILWAY_LABEL_MARGIN_TOP_BOTTOM = CGFloat(5)
    static let RAILWAY_LABEL_FONT_SIZE = CGFloat(12)
    private static let RAILWAY_LABEL_HEIGHT = "".heightOfString(font: UIFont.boldSystemFont(ofSize: RAILWAY_LABEL_FONT_SIZE))
    static let CELL_HEIGHT =
        DIST_LABEL_MARGIN_TOP +
        DIST_LABEL_HEIGHT +
        NAME_LABEL_MARGIN_TOP +
        NAME_LABEL_HEIGHT +
        ADDRESS_LABEL_MARGIN_TOP +
        ADDRESS_LABEL_HEIGHT +
        STATION_LABEL_MARGIN_TOP +
        STATION_LABEL_HEIGHT +
        RAILWAY_LABEL_MARGIN_TOP_BOTTOM +
        RAILWAY_LABEL_HEIGHT +
        RAILWAY_LABEL_MARGIN_TOP_BOTTOM
    
    var stateLabel: UILabel!
    var distLabel: UILabel!
    var nameLabel: UILabel!
    var addressLabel: UILabel!
    var stationLabel: UILabel!
    var railwayLabel: UILabel!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let salg = safeAreaLayoutGuide
        
        self.backgroundColor = .white
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3
        
        stateLabel = UILabel()
        stateLabel.textColor = .lightGray
        stateLabel.numberOfLines = 1
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stateLabel)
        stateLabel.topAnchor.constraint(equalTo: salg.topAnchor, constant: 5).isActive = true
        stateLabel.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 5).isActive = true
        
        distLabel = UILabel()
        distLabel.textColor = .lightGray
        distLabel.numberOfLines = 1
        distLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(distLabel)
        distLabel.topAnchor.constraint(equalTo: salg.topAnchor, constant: 5).isActive = true
        distLabel.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -5).isActive = true
        
        nameLabel = UILabel()
        nameLabel.numberOfLines = 1
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: distLabel.bottomAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 5).isActive = true
        
        addressLabel = UILabel()
        addressLabel.numberOfLines = 1
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addressLabel)
        addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 5).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -5).isActive = true
        
        stationLabel = UILabel()
        stationLabel.numberOfLines = 1
        stationLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stationLabel)
        stationLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5).isActive = true
        stationLabel.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 5).isActive = true
        stationLabel.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -5).isActive = true
        
        railwayLabel = UILabel()
        railwayLabel.numberOfLines = 1
        railwayLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(railwayLabel)
        railwayLabel.topAnchor.constraint(equalTo: stationLabel.bottomAnchor, constant: 5).isActive = true
        railwayLabel.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 5).isActive = true
        railwayLabel.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -5).isActive = true
        railwayLabel.bottomAnchor.constraint(equalTo: salg.bottomAnchor, constant: -5).isActive = true
        
    }
    
}
