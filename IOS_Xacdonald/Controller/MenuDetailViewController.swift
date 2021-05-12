//
//  MenuDetailViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/04/18.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit
import PINRemoteImage
import RxSwift
import RxCocoa

class MenuDetailViewController: UIViewController {
    
    private var menuItem: MenuItem!
    private var disposeBag: DisposeBag!
    
    init(menuItem: MenuItem) {
        super.init(nibName: nil, bundle: nil)
        self.menuItem = menuItem
        self.disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let salg = view.safeAreaLayoutGuide
        
        self.navigationItem.title = menuItem.name
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: salg.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: salg.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: salg.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: salg.bottomAnchor).isActive = true
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(view)
        view.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.pin_setImage(from: URL(string: menuItem.imageUrl))
        view.addSubview(img)
        img.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        img.widthAnchor.constraint(equalToConstant: 300).isActive = true
        img.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        let detail = UILabel()
        detail.translatesAutoresizingMaskIntoConstraints = false
        detail.text = menuItem.description
        detail.font = UIFont.systemFont(ofSize: 16)
        detail.numberOfLines = 0
        view.addSubview(detail)
        detail.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 10).isActive = true
        detail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        detail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        let detailInfo = UIButton()
        detailInfo.translatesAutoresizingMaskIntoConstraints = false
        detailInfo.setAttributedTitle(NSAttributedString(
                                        string: "商品詳細情報",
                                        attributes: [
                                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                            NSAttributedString.Key.foregroundColor: UIColor.init(hex: "666666"),
                                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
                                        ]),
                                      for: .normal)
        detailInfo.rx.tap
            .subscribe(
                onNext: {
                    // detailInfo tapped process
                })
            .disposed(by: disposeBag)
        view.addSubview(detailInfo)
        detailInfo.topAnchor.constraint(equalTo: detail.bottomAnchor, constant: 20).isActive = true
        detailInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        let price = UILabel()
        let priceMts = NSMutableAttributedString()
        priceMts.append(NSAttributedString(
                            string: "単品 ",
                            attributes: [
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)
                            ]))
        priceMts.append(NSAttributedString(
                            string: "¥ ",
                            attributes: [
                                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13),
                            ]))
        priceMts.append(NSAttributedString(
                            string: Formatter.formatForPrice(number: menuItem.price),
                            attributes: [
                                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
                            ]))
        price.attributedText = priceMts
        price.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(price)
        price.topAnchor.constraint(equalTo: detailInfo.bottomAnchor, constant: 20).isActive = true
        price.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        price.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        let order = UIButton()
        order.setAttributedTitle(
            NSAttributedString(
                string: "オーダーする",
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
                    NSAttributedString.Key.foregroundColor: UIColor.black
                ]),
            for: .normal)
        order.backgroundColor = UIColor.init(hex: "ffcc33")
        order.layer.cornerRadius = 5
        order.layer.borderWidth = 1
        order.layer.borderColor = UIColor.init(hex: "ffcc33").cgColor
        order.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        order.translatesAutoresizingMaskIntoConstraints = false
        order.rx.tap.subscribe(
            onNext: {
                self.navigationController?.pushViewController(
                    ShopViewController(menuItem: self.menuItem),
                    animated: true)
            }).disposed(by: disposeBag)
        view.addSubview(order)
        order.topAnchor.constraint(equalTo: detailInfo.bottomAnchor, constant: 20).isActive = true
        order.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        order.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
    
}
