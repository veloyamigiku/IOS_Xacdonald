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
    private var mainSv:UIStackView!
    private var firstRowSv: UIStackView!
    private var riv1: RecommendedItemView!
    private var riv2: RecommendedItemView!
    private var secondRowSv: UIStackView!
    private var riv3: RecommendedItemView!
    private var riv4: RecommendedItemView!
    private var dummy: UIView!
    
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
        //mainSv.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        //mainSv.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        firstRowSv = UIStackView()
        firstRowSv.axis = .horizontal
        firstRowSv.translatesAutoresizingMaskIntoConstraints = false
        mainSv.addArrangedSubview(firstRowSv)
        //firstRowSv.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        //firstRowSv.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        //firstRowSv.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        //firstRowSv.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        
        riv1 = RecommendedItemView()
        riv1.translatesAutoresizingMaskIntoConstraints = false
        firstRowSv.addArrangedSubview(riv1)
        riv1.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        
        riv2 = RecommendedItemView()
        riv2.translatesAutoresizingMaskIntoConstraints = false
        firstRowSv.addArrangedSubview(riv2)
        riv2.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        
        secondRowSv = UIStackView()
        secondRowSv.axis = .horizontal
        secondRowSv.translatesAutoresizingMaskIntoConstraints = false
        mainSv.addArrangedSubview(secondRowSv)
        //secondRowSv.topAnchor.constraint(equalTo: firstRowSv.bottomAnchor, constant: 0).isActive = true
        //secondRowSv.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        //secondRowSv.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        //secondRowSv.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        
        riv3 = RecommendedItemView()
        riv3.translatesAutoresizingMaskIntoConstraints = false
        secondRowSv.addArrangedSubview(riv3)
        riv3.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        
        riv4 = RecommendedItemView()
        riv4.translatesAutoresizingMaskIntoConstraints = false
        secondRowSv.addArrangedSubview(riv4)
        riv4.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        
        dummy = UIView()
        dummy.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dummy)
        //dummy.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        dummy.topAnchor.constraint(equalTo: mainSv.bottomAnchor).isActive = true
        dummy.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        dummy.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        dummy.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
