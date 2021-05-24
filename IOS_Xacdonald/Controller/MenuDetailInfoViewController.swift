//
//  MenuDetailInfoViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/13.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class MenuDetailInfoViewController: CVPVCViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var menuItemDetailData: [MenuItemDetailData]!
    
    init(menuItemDetailData: [MenuItemDetailData], index: Int) {
        super.init(index: index)
        self.menuItemDetailData = menuItemDetailData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let salg = view.safeAreaLayoutGuide;
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuItemDetailHeaderView.self, forHeaderFooterViewReuseIdentifier: "MenuItemDetailHeaderView")
        tableView.register(MenuItemDetailItemTableViewCell.self, forCellReuseIdentifier: "MenuItemDetailItemTableViewCell")
        // 空のセルの区切り線を表示しない。
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: salg.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: salg.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: salg.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: salg.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemDetailData[section].menuItemDetailItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if menuItemDetailData[indexPath.section].menuItemDetailItems[indexPath.row] is MenuItemDetailItem {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemDetailItemTableViewCell", for: indexPath) as! MenuItemDetailItemTableViewCell
            cell.menuItemDetailItem = menuItemDetailData[indexPath.section].menuItemDetailItems[indexPath.row] as? MenuItemDetailItem
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if menuItemDetailData[section].menuItemDetailHeader is MenuItemDetailHeader {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MenuItemDetailHeaderView") as! MenuItemDetailHeaderView
            header.menuItemDetailHeader = menuItemDetailData[section].menuItemDetailHeader as? MenuItemDetailHeader
            return header
        }
        return UIView()
    }
    
}
