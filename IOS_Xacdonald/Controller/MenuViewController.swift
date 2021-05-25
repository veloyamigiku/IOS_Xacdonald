//
//  MenuViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/04/03.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit
import PINRemoteImage
import RxSwift

class MenuViewController: CVPVCViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private static let INTER_ITEM_SPACING = CGFloat(10)
    private static let SECTION_INSET_LEFT_RIGHT = CGFloat(10)
    
    private var categoryID: String!
    private var viewModel: MenuViewModel!
    private var menuItemsWithKeywordRanking: [MenuItemsWithKeywordRanking]!
    private var collectionView: UICollectionView!
    
    init(categoryID: String, index: Int) {
        super.init(index: index)
        self.categoryID = categoryID
        self.viewModel = MenuViewModel()
        menuItemsWithKeywordRanking = []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        
        let salg = view.safeAreaLayoutGuide
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumInteritemSpacing = MenuViewController.INTER_ITEM_SPACING
        collectionViewFlowLayout.minimumLineSpacing = 20
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(
            top: 10,
            left: MenuViewController.SECTION_INSET_LEFT_RIGHT,
            bottom: 20,
            right: MenuViewController.SECTION_INSET_LEFT_RIGHT)
        collectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: salg.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: salg.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: salg.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: salg.bottomAnchor).isActive = true
        collectionView.register(
            MenuCollectionViewCell.self,
            forCellWithReuseIdentifier: "MenuCollectionViewCell")
        collectionView.register(
            MenuCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "MenuCollectionReusableView")
        
        viewModel
            .getMenuItemWithKeywordRanking(catetoryID: categoryID)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { menuItemsWithKeywordRanking in
                    print("===MenuViewController next===")
                    self.menuItemsWithKeywordRanking = menuItemsWithKeywordRanking
                    self.collectionView.reloadData()
                    //print(menuItem)
                },
                onError: { error in
                    print("===MenuViewController error===")
                    print(error)
                },
                onCompleted: {
                    print("===MenuViewController completed===")
                },
                onDisposed: {
                    print("===MenuViewController disposed===")
                })
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return menuItemsWithKeywordRanking.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItemsWithKeywordRanking[section].MenuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
        let menuItem = menuItemsWithKeywordRanking[indexPath.section].MenuItems[indexPath.row]
        cell.nameLabel.text = menuItem.name
        cell.image.pin_setImage(from: URL(string: menuItem.imageUrl))
        cell.priceLabel.text = "¥"
        cell.priceValueLabel.text = Formatter.formatForPrice(number: menuItem.price)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - (MenuViewController.INTER_ITEM_SPACING / 2) - (MenuViewController.SECTION_INSET_LEFT_RIGHT * 2 / 2), height: MenuCollectionViewCell.HEIGHT)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "MenuCollectionReusableView",
                for: indexPath) as! MenuCollectionReusableView
            header.label.text = menuItemsWithKeywordRanking[indexPath.section].keywordRanking.keyword
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: MenuCollectionReusableView.HEIGHT)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuItem = menuItemsWithKeywordRanking[indexPath.section].MenuItems[indexPath.row]
        let menuDetailViewController = MenuDetailViewController(menuItem: menuItem)
        menuDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(
            menuDetailViewController,
            animated: true)
        
    }
    
}
