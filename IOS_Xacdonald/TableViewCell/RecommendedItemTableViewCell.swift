//
//  RecommendedItemTableViewCell.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/02/17.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class RecommendedItemTableViewCell: UITableViewCell {
    
    private var titleLabel: UILabel!
    private var mainSv: UIStackView!
    private var dummy: UIView!
    var recommendedItemSet: RecommendedItemSet! {
        didSet {
            deployAndLayout(recommendedItemSet: recommendedItemSet)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = UILabel()
        titleLabel.text = "おすすめのメニュー"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        
        mainSv = UIStackView()
        mainSv.axis = .vertical
        mainSv.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainSv)
        mainSv.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        mainSv.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        mainSv.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
        dummy = UIView()
        dummy.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dummy)
        dummy.topAnchor.constraint(equalTo: mainSv.bottomAnchor).isActive = true
        dummy.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        dummy.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        dummy.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    func deployAndLayout(recommendedItemSet: RecommendedItemSet) {
        
        for rowSv in mainSv.subviews {
            rowSv.removeFromSuperview()
        }
        
        var recommendedItemsByStackView: [[RecommendedItem]] = []
        var recommendedItems: [RecommendedItem] = []
        for recommendedItem in recommendedItemSet.items {
            recommendedItems.append(recommendedItem)
            if recommendedItems.count == 2 {
                recommendedItemsByStackView.append(recommendedItems)
                recommendedItems = []
            }
        }
        if recommendedItems.count >= 1 {
            recommendedItemsByStackView.append(recommendedItems)
        }
        for recommendedItems in recommendedItemsByStackView {
            let sv = UIStackView()
            sv.axis = .horizontal
            sv.distribution = .fillEqually
            sv.translatesAutoresizingMaskIntoConstraints = false
            mainSv.addArrangedSubview(sv)
            sv.leadingAnchor.constraint(equalTo: mainSv.leadingAnchor).isActive = true
            sv.trailingAnchor.constraint(equalTo: mainSv.trailingAnchor).isActive = true
            for recommendedItem in recommendedItems {
                let riv = RecommendedItemView()
                sv.addArrangedSubview(riv)
                riv.recommendedItem = recommendedItem
            }
            let dummyViewCount = 2 - recommendedItems.count
            if dummyViewCount == 0 {
                continue
            }
            for _ in 1 ... dummyViewCount {
                let dummyView = UIView()
                dummyView.translatesAutoresizingMaskIntoConstraints = false
                sv.addArrangedSubview(dummyView)
            }
        }
        
    }

}
