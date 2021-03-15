//
//  CouponPageViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/03/03.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class CouponPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    private static let COUPON_CATEGORY_ID_LIST = [
        ModelConstant.CATEGORY_ID_PS5,
        ModelConstant.CATEGORY_ID_XBOX_SERIES_X_S,
        ModelConstant.CATEGORY_ID_PS4,
        ModelConstant.CATEGORY_ID_XBOX_ONE,
        ModelConstant.CATEGORY_ID_SW,
        ModelConstant.CATEGORY_ID_PS3
    ]
    
    private var controllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        for couponCategoryID in CouponPageViewController.COUPON_CATEGORY_ID_LIST {
            print(couponCategoryID)
            let couponViewController = CouponViewController(couponCategoryID: couponCategoryID)
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
