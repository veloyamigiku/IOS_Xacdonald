//
//  MenuOrderBottomTableViewCell.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/06/13.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class MenuOrderBottomTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let salg = safeAreaLayoutGuide
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: salg.topAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -5).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: salg.bottomAnchor, constant: -5).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
