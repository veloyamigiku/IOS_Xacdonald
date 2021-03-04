//
//  CouponItemTableViewCell.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/03/05.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit
import PINRemoteImage

class CouponItemTableViewCell: UITableViewCell {
    
    private var itemImage: UIImageView!
    private var itemName: UILabel!
    private var itemDescButton: UIButton!
    private var itemPrice: UILabel!
    var couponItem: CouponItem! {
        didSet {
            guard let item = couponItem else {
                return
            }
            itemImage.pin_setImage(from: URL(string: item.imageUrl))
            itemName.text = item.name
            itemPrice.text = "¥" + String(item.price)
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        itemImage = UIImageView()
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemImage)
        itemImage.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        itemImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        itemImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        itemImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        
        itemName = UILabel()
        itemName.numberOfLines = 3
        itemName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemName)
        itemName.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 5).isActive = true
        itemName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        itemName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        
        itemDescButton = UIButton()
        itemDescButton.setAttributedTitle(NSAttributedString(
                                            string: "詳細",
                                            attributes: [
                                                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                NSAttributedString.Key.foregroundColor: UIColor.black
                                            ]),
                                          for: .normal)
        itemDescButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemDescButton)
        itemDescButton.topAnchor.constraint(equalTo: itemName.bottomAnchor, constant: 5).isActive = true
        itemDescButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        
        itemPrice = UILabel()
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemPrice)
        itemPrice.topAnchor.constraint(equalTo: itemDescButton.bottomAnchor, constant: 5).isActive = true
        itemPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        itemPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        itemPrice.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
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
