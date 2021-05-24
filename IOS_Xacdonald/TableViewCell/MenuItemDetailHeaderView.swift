//
//  MenuItemDetailHeaderView.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/16.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class MenuItemDetailHeaderView: UITableViewHeaderFooterView {
    
    private var label: UILabel!
    var menuItemDetailHeader: MenuItemDetailHeader! {
        didSet {
            guard let midh = menuItemDetailHeader else {
                return
            }
            label.text = midh.label
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        //　ヘッダーの背景色をカスタマイズする場合のサンプルコード。
        /*let bv = UIView()
        bv.backgroundColor = .red
        backgroundView = bv*/
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        addSubview(label)
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
