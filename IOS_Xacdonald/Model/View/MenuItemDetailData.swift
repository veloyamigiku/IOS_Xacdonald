//
//  MenuItemDetailData.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/14.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import Foundation

class MenuItemDetailData {
    
    var menuItemDetailHeader: MenuItemDetailHeaderBase
    
    var menuItemDetailItems: [MenuItemDetailItemBase]
    
    init(menuItemDetailHeader: MenuItemDetailHeaderBase, menuItemDetailItems: [MenuItemDetailItemBase]) {
        self.menuItemDetailHeader = menuItemDetailHeader
        self.menuItemDetailItems = menuItemDetailItems
    }
    
}
