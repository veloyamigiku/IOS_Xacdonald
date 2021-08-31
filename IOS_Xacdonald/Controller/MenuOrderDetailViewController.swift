//
//  MenuOrderDetailViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/28.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PINRemoteImage

class MenuOrderDetailViewController: UIViewController {
    
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
        
        self.navigationItem.title = menuItem.name
        
        let salg = view.safeAreaLayoutGuide
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: salg.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: salg.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: salg.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: salg.bottomAnchor).isActive = true
        
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mainView)
        mainView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let itemImage = UIImageView()
        itemImage.pin_setImage(from: URL(string: menuItem.imageUrl))
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(itemImage)
        itemImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
        itemImage.widthAnchor.constraint(equalTo: mainView.widthAnchor, constant: -10).isActive = true
        itemImage.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        itemImage.heightAnchor.constraint(equalTo: mainView.widthAnchor, constant: -10).isActive = true
        
        let detail = UILabel()
        detail.translatesAutoresizingMaskIntoConstraints = false
        detail.text = menuItem.description
        detail.font = UIFont.systemFont(ofSize: 16)
        detail.numberOfLines = 0
        mainView.addSubview(detail)
        detail.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 10).isActive = true
        detail.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
        detail.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
        
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
                    var menuDetailInfoViewControllerIndex = 0
                    var menuDetailInfoViewControllers: [MenuDetailInfoViewController] = []
                    for menuDetailInfoType in ModelConstant.MENU_DETAIL_INFO_TYPE_LIST {
                        let menuItemDetailData = MenuDetailInfo.fromMenuDetailInfoTypeToMenuDetailItemData(
                            menuDetailInfoType: menuDetailInfoType,
                            menuItem: self.menuItem)
                        menuDetailInfoViewControllers.append(MenuDetailInfoViewController(
                                                                menuItemDetailData: menuItemDetailData,
                                                                index: menuDetailInfoViewControllerIndex))
                        menuDetailInfoViewControllerIndex += 1
                    }
                    let menuDetailInfoRootViewController = CVPVCViewControllerB(
                        tabNameList: ModelConstant.MENU_DETAIL_INFO_TAB_LIST,
                        viewControllerList: menuDetailInfoViewControllers)
                    menuDetailInfoRootViewController.navigationItem.title = self.menuItem.name
                    self.navigationController?.pushViewController(
                        menuDetailInfoRootViewController,
                        animated: true)
                })
            .disposed(by: disposeBag)
        mainView.addSubview(detailInfo)
        detailInfo.topAnchor.constraint(equalTo: detail.bottomAnchor, constant: 20).isActive = true
        detailInfo.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
        
        let price = UILabel()
        let priceMas = NSMutableAttributedString()
        priceMas.append(NSAttributedString(
                            string: "単品",
                            attributes: [
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)
                            ]))
        priceMas.append(NSAttributedString(
                            string: "¥ ",
                            attributes: [
                                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)
                            ]))
        priceMas.append(NSAttributedString(
                            string: Formatter.formatForPrice(number: menuItem.price),
                            attributes: [
                                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)
                            ]))
        price.attributedText = priceMas
        price.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(price)
        price.topAnchor.constraint(equalTo: detailInfo.bottomAnchor, constant: 20).isActive = true
        price.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
        price.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
        
        let orderCountUp = UIButton()
        
        let orderCount = UILabel()
        
        let orderCountDown = UIButton()
        
        let regiCounter = UIButton()
        regiCounter.translatesAutoresizingMaskIntoConstraints = false
        let regiCounterStr = NSAttributedString(
            string: "レジに進む",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)
            ])
        regiCounter.setAttributedTitle(regiCounterStr, for: .normal)
        regiCounter.layer.cornerRadius = 5
        regiCounter.layer.borderWidth = 1
        regiCounter.layer.borderColor = UIColor.black.cgColor
        regiCounter.rx.tap
            .subscribe(onNext: {
                print("tap regiCounter.")
            })
            .disposed(by: disposeBag)
        mainView.addSubview(regiCounter)
        regiCounter.widthAnchor.constraint(
            equalTo: mainView.widthAnchor,
            multiplier: 0.5,
            constant: -15).isActive = true
        regiCounter.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 20).isActive = true
        regiCounter.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
        regiCounter.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10).isActive = true
        
        let addCartButton = UIButton()
        addCartButton.translatesAutoresizingMaskIntoConstraints = false
        let addCartStr = NSAttributedString(
            string: "カートに追加",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)])
        addCartButton.setAttributedTitle(addCartStr, for: .normal)
        addCartButton.backgroundColor = UIColor.init(hex: "ffcc33")
        addCartButton.layer.cornerRadius = 5
        addCartButton.layer.borderWidth = 1
        addCartButton.layer.borderColor = UIColor.init(hex: "ffcc33").cgColor
        addCartButton.rx.tap.subscribe(
            onNext: {
                if let menuOrderRootViewController = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 2] as? MenuOrderRootViewController {
                    menuOrderRootViewController.addOrderMenuItem(menuItem: self.menuItem)
                    self.navigationController?.popViewController(animated: true)
                }
            }).disposed(by: disposeBag)
        mainView.addSubview(addCartButton)
        addCartButton.widthAnchor.constraint(
            equalTo: mainView.widthAnchor,
            multiplier: 0.5,
            constant: -15).isActive = true
        addCartButton.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 20).isActive = true
        
        addCartButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
        addCartButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    
    
}
