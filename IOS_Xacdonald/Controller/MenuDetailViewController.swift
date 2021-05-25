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

enum MenuDetailViewControllerError: Error {
    case implementBug
}

class MenuDetailViewController: UIViewController {
    
    private static let MENU_ITEM_DETAIL_HEADER_REVIEW = "レビュー"
    private static let MENU_ITEM_DETAIL_ITEM_REVIEW_RATE = "レビュー平均"
    private static let MENU_ITEM_DETAIL_ITEM_REVIEW_COUNT = "レビュー件数"
    private static let MENU_ITEM_DETAIL_HEADER_POINT = "ポイント"
    private static let MENU_ITEM_DETAIL_ITEM_POINT_AMOUNT = "基本ポイント数"
    private static let MENU_ITEM_DETAIL_ITEM_POINT_TIMES = "基本ポイント倍率"
    private static let MENU_ITEM_DETAIL_ITEM_POINT_BONUS_AMOUNT = "ストアボーナス数"
    private static let MENU_ITEM_DETAIL_ITEM_POINT_BONUS_TIMES = "ストアボーナス倍率"
    private static let MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_AMOUNT = "プレミアム会員向けの基本ポイント数"
    private static let MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_TIMES = "プレミアム会員向けの基本ポイント倍率"
    private static let MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_BONUS_AMOUNT = "プレミアム会員向けのストアボーナス数"
    private static let MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_BONUS_TIMES = "プレミアム会員向けのストアボーナス倍率"
    private static let MENU_ITEM_DETAIL_HEADER_SELLER = "ストア"
    private static let MENU_ITEM_DETAIL_ITEM_SELLER_NAME = "ストア名"
    private static let MENU_ITEM_DETAIL_ITEM_SELLER_RATE = "レビュー平均"
    private static let MENU_ITEM_DETAIL_ITEM_SELLER_COUNT = "レビュー件数"
    
    private static let MENU_DETAIL_INFO_TAB_LIST = [
        ModelConstant.MENU_DETAIL_INFO_TAB_DETAIL1,
        ModelConstant.MENU_DETAIL_INFO_TAB_DETAIL2,
        ModelConstant.MENU_DETAIL_INFO_TAB_DETAIL3
    ]
    
    private static let MENU_DETAIL_INFO_TYPE_LIST = [
        ModelConstant.MENU_DETAIL_INFO_TYPE_DETAIL1,
        ModelConstant.MENU_DETAIL_INFO_TYPE_DETAIL2,
        ModelConstant.MENU_DETAIL_INFO_TYPE_DETAIL3
    ]
    
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
                    var menuDetailInfoViewControllerIndex = 0
                    var menuDetailInfoViewControllers: [MenuDetailInfoViewController] = []
                    for menuDetailInfoType in MenuDetailViewController.MENU_DETAIL_INFO_TYPE_LIST {
                        let menuItemDetailData = self.fromMenuDetailInfoTypeToMenuDetailItemData(
                            menuDetailInfoType: menuDetailInfoType,
                            menuItem: self.menuItem)
                        menuDetailInfoViewControllers.append(
                            MenuDetailInfoViewController(
                                menuItemDetailData: menuItemDetailData,
                                index: menuDetailInfoViewControllerIndex))
                        menuDetailInfoViewControllerIndex += 1                  
                    }
                    let menuDetailInfoRootViewController = CVPVCViewControllerB(
                        tabNameList: MenuDetailViewController.MENU_DETAIL_INFO_TAB_LIST,
                        viewControllerList: menuDetailInfoViewControllers)
                    menuDetailInfoRootViewController.title = self.menuItem.name
                    self.navigationController?.pushViewController(menuDetailInfoRootViewController, animated: true)
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
    
    private func fromMenuDetailInfoTypeToMenuDetailItemData(menuDetailInfoType: Int, menuItem: MenuItem) -> [MenuItemDetailData] {
        switch menuDetailInfoType {
        case ModelConstant.MENU_DETAIL_INFO_TYPE_DETAIL1:
            let midhReview = MenuItemDetailHeader(label: MenuDetailViewController.MENU_ITEM_DETAIL_HEADER_REVIEW)
            let midiReviewRate = MenuItemDetailItem(
                label: MenuDetailViewController.MENU_ITEM_DETAIL_ITEM_REVIEW_RATE,
                value: String(menuItem.reviewRate))
            let midiReviewCount = MenuItemDetailItem(
                label: MenuDetailViewController.MENU_ITEM_DETAIL_ITEM_REVIEW_COUNT,
                value: String(menuItem.reviewCount))
            return [MenuItemDetailData(
                        menuItemDetailHeader: midhReview,
                        menuItemDetailItems: [
                            midiReviewRate,
                            midiReviewCount])]
        case ModelConstant.MENU_DETAIL_INFO_TYPE_DETAIL2:
            let midhPoint = MenuItemDetailHeader(label: MenuDetailViewController.MENU_ITEM_DETAIL_HEADER_POINT)
            let midiPointAmont = MenuItemDetailItem(
                label: MenuDetailViewController.MENU_ITEM_DETAIL_ITEM_POINT_AMOUNT,
                value: String(menuItem.pointAmount))
            let midiPointTimes = MenuItemDetailItem(
                label: MenuDetailViewController.MENU_ITEM_DETAIL_ITEM_POINT_TIMES,
                value: String(menuItem.pointTimes))
            let midiPointBonusAmount = MenuItemDetailItem(
                label: MenuDetailViewController.MENU_ITEM_DETAIL_ITEM_POINT_BONUS_AMOUNT,
                value: String(menuItem.pointBonusAmount))
            let midiPointBonusTimes = MenuItemDetailItem(
                label: MenuDetailViewController.MENU_ITEM_DETAIL_ITEM_POINT_BONUS_TIMES,
                value: String(menuItem.pointBonusTimes))
            let midiPointPremiumAmount = MenuItemDetailItem(
                label: MenuDetailViewController.MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_AMOUNT,
                value: String(menuItem.pointPremiumAmount))
            let midiPointPremiumTimes = MenuItemDetailItem(
                label: MenuDetailViewController.MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_TIMES,
                value: String(menuItem.pointPremiumTimes))
            let midiPointPremiumBonusAmount = MenuItemDetailItem(
                label: MenuDetailViewController.MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_BONUS_AMOUNT,
                value: String(menuItem.pointPremiumBonusAmount))
            let midiPointPremiumBonusTimes = MenuItemDetailItem(
                label: MenuDetailViewController.MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_BONUS_TIMES,
                value: String(menuItem.pointPremiumBonusTimes))
            return [MenuItemDetailData(
                        menuItemDetailHeader: midhPoint,
                        menuItemDetailItems: [
                            midiPointAmont,
                            midiPointTimes,
                            midiPointBonusAmount,
                            midiPointBonusTimes,
                            midiPointPremiumAmount,
                            midiPointPremiumTimes,
                            midiPointPremiumBonusAmount,
                            midiPointPremiumBonusTimes])]
        case ModelConstant.MENU_DETAIL_INFO_TYPE_DETAIL3:
            let midhSeller = MenuItemDetailHeader(label: MenuDetailViewController.MENU_ITEM_DETAIL_HEADER_SELLER)
            let midiSellerName = MenuItemDetailItem(
                label: MenuDetailViewController.MENU_ITEM_DETAIL_ITEM_SELLER_NAME,
                value: String(menuItem.sellerName))
            let midiSellerReviewRate = MenuItemDetailItem(
                label: MenuDetailViewController.MENU_ITEM_DETAIL_ITEM_SELLER_RATE,
                value: String(menuItem.sellerReviewRate))
            let midiSellerReviewCount = MenuItemDetailItem(
                label: MenuDetailViewController.MENU_ITEM_DETAIL_ITEM_SELLER_COUNT,
                value: String(menuItem.sellerReviewCount))
            return [MenuItemDetailData(
                        menuItemDetailHeader: midhSeller,
                        menuItemDetailItems: [
                            midiSellerName,
                            midiSellerReviewRate,
                            midiSellerReviewCount])]
        default:
            do {
                throw MenuDetailViewControllerError.implementBug
            } catch let error {
                print(error)
                return []
            }
        }
    }
    
}
