//
//  HomeViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2020/12/14.
//  Copyright © 2020 velo.yamigiku. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController, UITableViewDataSource {
    
    private var disposeBag: DisposeBag!
    private var tableView: UITableView!
    
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
        
        // ホーム画面用のテーブルビューを配置する。
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .blue
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: salg.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: salg.bottomAnchor, constant: 0).isActive = true
        tableView.dataSource = self
        tableView.register(LowPriceItemTableViewCell.self, forCellReuseIdentifier: "LowPriceItemTableViewCell")
        tableView.register(RecommendedItemTableViewCell.self, forCellReuseIdentifier: "RecommendedItemTableViewCell")
        
        disposeBag = DisposeBag()
        let itemRepository = ItemRepository()
        itemRepository.getRecommendedItem().subscribe(
            onNext: { items in
                for item in items {
                    print("name:" + item.name)
                    print("price:" + String(item.price))
                    print("image:" + item.imageUrl)
                }
            },
            onError: { err in
                print(err)
            },
            onCompleted: {
                print("Complete:")
            },
            onDisposed: {
                print("Disposed:")
            }).disposed(by: disposeBag)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LowPriceItemTableViewCell") as! LowPriceItemTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendedItemTableViewCell") as! RecommendedItemTableViewCell
            return cell
        }
        
    }

}
