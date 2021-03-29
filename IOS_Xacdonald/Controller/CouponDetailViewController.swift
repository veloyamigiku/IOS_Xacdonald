//
//  CouponDetailViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/03/21.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class CouponDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private var couponItem: CouponItem!
    
    init(couponItem: CouponItem) {
        super.init(nibName: nil, bundle: nil)
        self.couponItem = couponItem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let couponDetailView = CouponDetailView(frame: CGRect.zero, couponItem: couponItem)
        couponDetailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(couponDetailView)
        couponDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        couponDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        couponDetailView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let backgroundTap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapBackground(sender:)))
        backgroundTap.cancelsTouchesInView = false
        backgroundTap.delegate = self
        view.addGestureRecognizer(backgroundTap)
    }
    
    @objc func tapBackground(sender: UITapGestureRecognizer) {
        dismiss(
            animated: true,
            completion: nil)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == view {
            return true
        } else {
            return false
        }
    }
    
}
