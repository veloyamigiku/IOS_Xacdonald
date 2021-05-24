//
//  MenuItemDetailItemTableViewCell.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/16.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class MenuItemDetailItemTableViewCell: UITableViewCell {
    
    private var label: UILabel!
    private var value: UILabel!
    var menuItemDetailItem: MenuItemDetailItem! {
        didSet {
            guard let midi = menuItemDetailItem else {
                return
            }
            label.text = midi.label
            value.text = midi.value
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        addSubview(label)
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        value = UILabel()
        value.translatesAutoresizingMaskIntoConstraints = false
        value.font = UIFont.systemFont(ofSize: 13)
        value.textColor = .gray
        addSubview(value)
        value.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        value.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        value.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
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
