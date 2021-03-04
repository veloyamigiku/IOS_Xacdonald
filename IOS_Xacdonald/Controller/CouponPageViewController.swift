//
//  CouponPageViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/03/03.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class CouponPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    private static let COUPON_TYPE_LIST = [
        "朝",
        "ランチ",
        "夜"
    ]
    
    private var controllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        for couponType in CouponPageViewController.COUPON_TYPE_LIST {
            print(couponType)
            let couponViewController = CouponViewController(type: couponType)
            controllers.append(couponViewController)
        }
        
        self.setViewControllers(
            [controllers[0]],
            direction: .forward,
            animated: true,
            completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("before")
        if let index = controllers.firstIndex(of: viewController), index > 0 {
            return controllers[index - 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("after")
        
        if let index = controllers.firstIndex(of: viewController), index < controllers.count - 1 {
            return controllers[index + 1]
        } else {
            return nil
        }
    }

}
