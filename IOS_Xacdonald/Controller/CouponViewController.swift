//
//  CouponViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/03/02.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CouponViewController: UIViewController, UITableViewDataSource, CouponItemTableViewCellDelegate {
    
    private var couponCategoryID: String
    private var tableView: UITableView!
    private var couponViewModel: CouponViewModel
    private var disposeBag: DisposeBag
    private var couponItems: [CouponItem]
    private var index: Int!
    
    init(couponCategoryID: String, index: Int) {
        self.couponCategoryID = couponCategoryID
        self.index = index
        self.couponViewModel = CouponViewModel()
        self.disposeBag = DisposeBag()
        self.couponItems = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let salg = view.safeAreaLayoutGuide
        
        tableView = UITableView()
        tableView.backgroundColor = .brown
        tableView.register(CouponItemTableViewCell.self, forCellReuseIdentifier: "CouponItemTableViewCell")
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: salg.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: salg.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: salg.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: salg.bottomAnchor).isActive = true
        
        couponViewModel
            .getCouponItem(categoryID: couponCategoryID)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { couponItems in
                    self.couponItems = couponItems
                    self.tableView.reloadData()
                },
                onError: { error in
                    print("error")
                }).disposed(by: disposeBag)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return couponItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CouponItemTableViewCell") as! CouponItemTableViewCell
        cell.couponItem = couponItems[indexPath.row]
        cell.couponItemIdx = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func getIndex() -> Int {
        return index
    }
    
    func tapItemDescButton(itemIdx: Int) {
        print("itemIdx:" + String(itemIdx))
        let couponDetailViewController = CouponDetailViewController(couponItem: couponItems[itemIdx])
        couponDetailViewController.modalPresentationStyle = .overFullScreen
        couponDetailViewController.modalTransitionStyle = .crossDissolve
        present(
            couponDetailViewController,
            animated: true,
            completion: nil)
    }
    
}
