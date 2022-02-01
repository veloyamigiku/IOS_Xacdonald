//
//  MenuOrderRootViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/28.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class MenuOrderRootViewController: CVPVCViewControllerA {
    
    private var disposeBag: DisposeBag!
    private var preOrderMenuItem: MenuItem!
    private var menuOrderBottomView: MenuOrderBottomView!
    private var menuOrderBottomHeightConstraint: NSLayoutConstraint!
    private var menuOrderBottomHeightOpenConstraint: NSLayoutConstraint!
    private var menuOrderBottomHeightCloseConstraint: NSLayoutConstraint!
    private var blackViewForNavigationControllerHeightContraint: NSLayoutConstraint!
    private var blackViewForNavigationController: UIView!
    private var blackView: UIView!
    private var pageViewControllerBottomAnchorMenuOrderBottomViewTop: NSLayoutConstraint!
    private var pageViewControllerBottomAnchorParentViewBottom: NSLayoutConstraint!
    
    override init(
        tabNameList: [String],
        viewControllerList: [CVPVCViewController]) {
        super.init(tabNameList: tabNameList, viewControllerList: viewControllerList)
        disposeBag = DisposeBag()
    }
    
    init(
        tabNameList: [String],
        viewControllerList: [CVPVCViewController],
        preOrderMenuItem: MenuItem) {
        super.init(tabNameList: tabNameList, viewControllerList: viewControllerList)
        self.preOrderMenuItem = preOrderMenuItem
        disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if menuOrderBottomView.getOrderCount() > 0 {
            pageViewControllerBottomAnchorParentViewBottom.isActive = false
            pageViewControllerBottomAnchorMenuOrderBottomViewTop.isActive = true
            menuOrderBottomView.isHidden = false
        } else {
            pageViewControllerBottomAnchorParentViewBottom.isActive = true
            pageViewControllerBottomAnchorMenuOrderBottomViewTop.isActive = false
            menuOrderBottomView.isHidden = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        let statusHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height
        let navigationBarHeight = navigationController?.navigationBar.frame.height
        blackViewForNavigationControllerHeightContraint.constant = statusHeight! + navigationBarHeight!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let salg = view.safeAreaLayoutGuide
        
        pageViewControllerBottomConstraint.isActive = false
        
        blackViewForNavigationController = UIView()
        blackViewForNavigationController.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        blackViewForNavigationController.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.view.addSubview(blackViewForNavigationController)
        blackViewForNavigationControllerHeightContraint = blackViewForNavigationController.heightAnchor.constraint(equalToConstant: 0)
        blackViewForNavigationControllerHeightContraint.isActive = true
        blackViewForNavigationController.topAnchor.constraint(equalTo: (navigationController?.view.topAnchor)!).isActive = true
        blackViewForNavigationController.leadingAnchor.constraint(equalTo: (navigationController?.view.leadingAnchor)!).isActive = true
        blackViewForNavigationController.trailingAnchor.constraint(equalTo: (navigationController?.view.trailingAnchor)!).isActive = true
        blackViewForNavigationController.isHidden = true
        
        blackView = UIView()
        blackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        blackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blackView)
        view.bringSubviewToFront(blackView)
        blackView.topAnchor.constraint(equalTo: salg.topAnchor).isActive = true
        blackView.leadingAnchor.constraint(equalTo: salg.leadingAnchor).isActive = true
        blackView.trailingAnchor.constraint(equalTo: salg.trailingAnchor).isActive = true
        blackView.bottomAnchor.constraint(equalTo: pageViewControllerBottomAnchor).isActive = true
        blackView.isHidden = true
        
        menuOrderBottomView = MenuOrderBottomView()
        //menuOrderBottomView = MenuOrderBottomView(animateDuration: 0.5)
        menuOrderBottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuOrderBottomView)
        view.bringSubviewToFront(menuOrderBottomView)
        menuOrderBottomHeightCloseConstraint = menuOrderBottomView.heightAnchor.constraint(equalToConstant: MenuOrderBottomView.CLOSE_HEIGHT)
        menuOrderBottomHeightCloseConstraint.isActive = true
        menuOrderBottomHeightOpenConstraint = menuOrderBottomView.heightAnchor.constraint(equalTo: salg.heightAnchor, multiplier: 0.5)
        menuOrderBottomHeightOpenConstraint.isActive = false
        menuOrderBottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        menuOrderBottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        menuOrderBottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        /*menuOrderBottomView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                if self.menuOrderBottomHeightOpenConstraint.isActive {
                    self.menuOrderBottomHeightOpenConstraint.isActive = !self.menuOrderBottomHeightOpenConstraint.isActive
                    self.menuOrderBottomHeightCloseConstraint.isActive = !self.menuOrderBottomHeightCloseConstraint.isActive
                } else {
                    self.menuOrderBottomHeightCloseConstraint.isActive = !self.menuOrderBottomHeightCloseConstraint.isActive
                    self.menuOrderBottomHeightOpenConstraint.isActive = !self.menuOrderBottomHeightOpenConstraint.isActive
                }
                let preIsHidden = self.blackView.isHidden
                if preIsHidden == true {
                    self.blackView.isHidden = false
                    self.blackViewForNavigationController.isHidden = false
                }
                UIView.animate(
                    withDuration: 0.5,
                    animations: {() -> Void in
                        if preIsHidden == true {
                            self.blackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                            self.blackViewForNavigationController.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                        } else {
                            self.blackView.backgroundColor = UIColor.clear
                            self.blackViewForNavigationController.backgroundColor = UIColor.clear
                        }
                        self.view.layoutIfNeeded()
                    },
                    completion: { _ in
                        if preIsHidden == false {
                            self.blackView.isHidden = true
                            self.blackViewForNavigationController.isHidden = true
                        }
                    })
            })
            .disposed(by: disposeBag)*/
        pageViewControllerBottomAnchorMenuOrderBottomViewTop = pageViewControllerBottomAnchor.constraint(equalTo: menuOrderBottomView.topAnchor)
        pageViewControllerBottomAnchorMenuOrderBottomViewTop.isActive = false
        pageViewControllerBottomAnchorParentViewBottom = pageViewControllerBottomAnchor.constraint(equalTo: view.bottomAnchor)
        pageViewControllerBottomAnchorParentViewBottom.isActive = true
        
        if (preOrderMenuItem != nil) {
            self.navigationController?.pushViewController(
                MenuOrderDetailViewController(menuItem: preOrderMenuItem),
                animated: true)
        }
    }
    
    func addOrderMenuItem(menuItem: MenuItem) {
        menuOrderBottomView.addOrderMenuItem(menuItem: menuItem)
    }
    
}
