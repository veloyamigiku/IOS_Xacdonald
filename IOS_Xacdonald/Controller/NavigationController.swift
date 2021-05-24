//
//  NavigationController.swift
//  IOS_Xacdonald
//
//  Created by Leon on 2021/04/26.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ナビゲーションバーのアイテム（戻るボタン等）の色を設定する？
        navigationBar.tintColor = UIColor.black
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.view.layer.removeAllAnimations()
        if (animated) {
            let transition = CATransition()
            transition.duration = 0.1
            transition.type = .moveIn
            transition.subtype = .fromTop
            self.view.layer.add(
                transition,
                forKey: kCATransition)
        }
        return super.pushViewController(viewController, animated: false)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        self.view.layer.removeAllAnimations()
        if (animated) {
            let transition = CATransition()
            transition.duration = 0.1
            transition.type = .moveIn
            transition.subtype = .fromBottom
            self.view.layer.add(
                transition,
                forKey: kCATransition)
        }
        return super.popViewController(animated: false)
    }
}
