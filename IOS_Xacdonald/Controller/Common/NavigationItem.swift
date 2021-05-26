//
//  NavigationItem.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/27.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class NavigationItem {
    
    class func config(navigationItem: UINavigationItem) {
        
        let accountBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "account")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(tapAccountButton))
        navigationItem.leftBarButtonItem = accountBarButtonItem
        
        let titleImgView = UIImageView(image: UIImage(named: "top"))
        navigationItem.titleView = titleImgView
        
        let pointBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "point")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(tapPointButton))
        navigationItem.rightBarButtonItem = pointBarButtonItem
        
    }
    
    @objc private class func tapAccountButton() {
        print("tapAccountButton")
    }
    
    @objc private class func tapPointButton() {
        print("tapPointButton")
    }
    
}
