//
//  MenuItemDetailItem.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/14.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import Foundation

class MenuItemDetailItem : MenuItemDetailItemBase {
    
    var label: String
    
    var value: String
    
    init(label:String, value: String) {
        self.label = label
        self.value = value
    }
    
}
