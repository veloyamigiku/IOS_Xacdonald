//
//  HomeViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2020/12/14.
//  Copyright © 2020 velo.yamigiku. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource {
    
    private let dummyItems: [Int] = [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let salg = self.view.safeAreaLayoutGuide
        let cvfl = UICollectionViewFlowLayout()
        // コレクションビューのスクロール方向を垂直に設定する。
        cvfl.scrollDirection = .vertical
        // スクロール方向の間隔を設定する。
        cvfl.minimumLineSpacing = 10
        // コレクションビューのアイテムサイズを設定する。
        // アイテムサイズは縦・横両方とも画面の幅に設定する。
        cvfl.itemSize = CGSize(
            width: self.view.frame.size.width,
            height: self.view.frame.size.width)
        // コレクションビューを作成・配置する。
        let collectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: cvfl)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        collectionView.backgroundColor = .white
        self.view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: salg.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: salg.bottomAnchor, constant: 0).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HomeCollectionViewCell",
            for: indexPath) as! HomeCollectionViewCell
        
        return cell
    }

}
