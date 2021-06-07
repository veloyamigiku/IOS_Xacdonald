//
//  MenuOrderViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/06/08.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class MenuOrderViewController: MenuViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuItem = menuItemsWithKeywordRanking[indexPath.section].MenuItems[indexPath.row]
        let menuDetailViewController = MenuOrderDetailViewController(menuItem: menuItem)
        self.navigationController?.pushViewController(
            menuDetailViewController,
            animated: true)
    }
    
}
