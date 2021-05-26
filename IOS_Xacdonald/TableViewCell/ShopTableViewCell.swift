//
//  ShopTableViewCell.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/26.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class ShopTableViewCell: UITableViewCell {
    
    var stateLabel: UILabel!
    var distLabel: UILabel!
    var nameLabel: UILabel!
    var addressLabel: UILabel!
    var stationLabel: UILabel!
    var railwayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let salg = safeAreaLayoutGuide
        
        stateLabel = UILabel()
        stateLabel.textColor = .lightGray
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stateLabel)
        stateLabel.topAnchor.constraint(equalTo: salg.topAnchor, constant: 5).isActive = true
        stateLabel.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 5).isActive = true
        
        distLabel = UILabel()
        distLabel.textColor = .lightGray
        distLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(distLabel)
        distLabel.topAnchor.constraint(equalTo: salg.topAnchor, constant: 5).isActive = true
        distLabel.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -5).isActive = true
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 5).isActive = true
        
        addressLabel = UILabel()
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addressLabel)
        addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 5).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -5).isActive = true
        
        stationLabel = UILabel()
        stationLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stationLabel)
        stationLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5).isActive = true
        stationLabel.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 5).isActive = true
        stationLabel.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -5).isActive = true
        
        railwayLabel = UILabel()
        railwayLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(railwayLabel)
        railwayLabel.topAnchor.constraint(equalTo: stationLabel.bottomAnchor, constant: 5).isActive = true
        railwayLabel.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 5).isActive = true
        railwayLabel.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -5).isActive = true
        railwayLabel.bottomAnchor.constraint(equalTo: salg.bottomAnchor, constant: -5).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
