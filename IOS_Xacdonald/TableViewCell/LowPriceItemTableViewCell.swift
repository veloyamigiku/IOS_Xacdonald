//
//  LowPriceItemTableViewCell.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/02/15.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit
import PINRemoteImage

class LowPriceItemTableViewCell: UITableViewCell {
    
    private var dummy: UIView!
    private var img: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 画像を配置する。
        img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.pin_setImage(from: URL(string: "https://item-shopping.c.yimg.jp/i/j/lkestore_d1343-usb-rb-s"))
        contentView.addSubview(img)
        img.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        img.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
        // 上下の制約の警告を解消するためのコンポーネントを配置する。
        dummy = UIView()
        dummy.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dummy)
        dummy.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 0).isActive = true
        dummy.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        dummy.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        dummy.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
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
