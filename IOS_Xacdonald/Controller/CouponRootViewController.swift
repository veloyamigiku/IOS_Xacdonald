//
//  CouponRootViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/03/07.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class CouponRootViewController: UIViewController,
                                UICollectionViewDataSource,
                                UIPageViewControllerDataSource,
                                UIPageViewControllerDelegate,
                                UICollectionViewDelegateFlowLayout {
    
    private static let COUPON_CATEGORY_LIST = [
        "PS5",
        "XBox Series X/S",
        "PS4",
        "XBox One",
        "Nintendo Switch",
        "PS3",
    ]
    
    private static let COUPON_CATEGORY_ID_LIST = [
        ModelConstant.CATEGORY_ID_PS5,
        ModelConstant.CATEGORY_ID_XBOX_SERIES_X_S,
        ModelConstant.CATEGORY_ID_PS4,
        ModelConstant.CATEGORY_ID_XBOX_ONE,
        ModelConstant.CATEGORY_ID_SW,
        ModelConstant.CATEGORY_ID_PS3
    ]
    
    private var initDidAppearFlag: Bool!
    
    private var pageIdx: Int!
    
    private var vcListForPVC: [UIViewController]!
    
    private var pageViewController: UIPageViewController!
    
    private var collectionView: UICollectionView!
    
    override func viewDidAppear(_ animated: Bool) {
        if initDidAppearFlag {
            self.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
            initDidAppearFlag = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDidAppearFlag = true
        
        pageIdx = 0
        
        let salg = view.safeAreaLayoutGuide
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .cyan
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CouponCollectionViewCell.self, forCellWithReuseIdentifier: "CouponCollectionViewCell")
        view.addSubview(collectionView)
        let height = "".heightOfString(font: UIFont.systemFont(ofSize: 17))
        collectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
        collectionView.topAnchor.constraint(equalTo: salg.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: 0).isActive = true
        
        pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        var index = 0
        vcListForPVC = []
        for couponCategoryID in CouponRootViewController.COUPON_CATEGORY_ID_LIST {
            print(couponCategoryID)
            let couponViewController = CouponViewController(couponCategoryID: couponCategoryID, index: index)
            vcListForPVC.append(couponViewController)
            index = index + 1
        }
        pageViewController.setViewControllers(
            [vcListForPVC[0]],
            direction: .forward,
            animated: true,
            completion: nil)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewController.view.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0).isActive = true
        pageViewController.view.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 0).isActive = true
        pageViewController.view.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: 0).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: salg.bottomAnchor, constant: 0).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CouponRootViewController.COUPON_CATEGORY_LIST.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CouponCollectionViewCell",
            for: indexPath) as! CouponCollectionViewCell
        cell.label.text = CouponRootViewController.COUPON_CATEGORY_LIST[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(
            width: CouponRootViewController.COUPON_CATEGORY_LIST[indexPath.row].widthOfString(font: UIFont.systemFont(ofSize: 17)),
            height: CouponRootViewController.COUPON_CATEGORY_LIST[indexPath.row].heightOfString(font: UIFont.systemFont(ofSize: 17)))
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        pageViewController.setViewControllers(
            [vcListForPVC[indexPath.row]],
            direction: pageIdx < indexPath.row ? .forward : .reverse,
            animated: true,
            completion: nil)
        pageIdx = indexPath.row
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = vcListForPVC.firstIndex(of: viewController), index > 0 {
            return vcListForPVC[index - 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = vcListForPVC.firstIndex(of: viewController), index < vcListForPVC.count - 1 {
            return vcListForPVC[index + 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let couponViewController = pageViewController.viewControllers?.first as! CouponViewController
        collectionView.selectItem(
            at: IndexPath(row: couponViewController.getIndex(), section: 0),
            animated: true,
            scrollPosition: .centeredHorizontally)
        pageIdx = couponViewController.getIndex()
    }
    
}
