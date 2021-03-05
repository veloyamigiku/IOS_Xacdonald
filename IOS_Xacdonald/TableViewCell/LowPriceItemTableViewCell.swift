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
    var lowPriceItem: LowPriceItem! {
        didSet {
            guard let lpi = lowPriceItem else { return }
            img.pin_setImage(from: URL(string: lpi.url))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 画像を配置する。
        img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(img)
        img.widthAnchor.constraint(equalToConstant: 300).isActive = true
        img.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        img.heightAnchor.constraint(equalToConstant: 300).isActive = true
        img.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        
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
