//
//  ShopDetailCalloutAccessoryView.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/10.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class ShopDetailCalloutAccessoryView: UIView {
    
    var name: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        name = UILabel()
        name.font = UIFont.systemFont(ofSize: 13)
        name.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(name)
        name.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        name.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        let comment = UILabel()
        comment.font = UIFont.systemFont(ofSize: 13)
        comment.text = "店舗を選択してください"
        comment.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(comment)
        comment.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
        comment.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        comment.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        comment.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
