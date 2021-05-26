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
    private var viewModel: HomeViewModel!
    private var items: [Any] = []
    private var tableView: UITableView!
    
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
        viewModel = HomeViewModel()
        viewModel
            .getItem()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { items in
                    print("===onNext===")
                    self.items = items
                    self.tableView.reloadData()
                },
                onError: { err in
                    print("===onError===")
                },
                onCompleted: {
                    print("===onCompleted===")
                },
                onDisposed: {
                    print("===onDisposed===")
                })
            .disposed(by: disposeBag)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if items[indexPath.row] is LowPriceItem {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LowPriceItemTableViewCell") as! LowPriceItemTableViewCell
            let lowPriceItem = items[indexPath.row] as! LowPriceItem
            cell.lowPriceItem = lowPriceItem
            return cell
        } else if items[indexPath.row] is RecommendedItemSet {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendedItemTableViewCell") as! RecommendedItemTableViewCell
            let recommendedItemSet = items[indexPath.row] as! RecommendedItemSet
            cell.recommendedItemSet = recommendedItemSet
            return cell
        } else {
            print("想定外の商品モデルがテーブルのリストに存在します。実装を確認して下さい。")
            return UITableViewCell()
        }
        
    }
    
}
