//
//  CVPVCBaseViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/16.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class CVPVCBaseViewController: UIViewController,
                               UICollectionViewDataSource,
                               UIPageViewControllerDataSource,
                               UIPageViewControllerDelegate,
                               UICollectionViewDelegateFlowLayout {
    
    open var tabNameList: [String]!
    
    private var initDidAppearFlag: Bool!
    
    private var pageIdx: Int!
    
    private var viewControllerList: [CVPVCViewController]!
    
    private var pageViewController: UIPageViewController!
    
    open var collectionView: UICollectionView!
    
    open var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    open var pageViewControllerTopAnchor: NSLayoutYAxisAnchor!
    
    open var pageViewControllerBottomAnchor: NSLayoutYAxisAnchor!
    
    open var pageViewControllerBottomConstraint: NSLayoutConstraint!
    
    init(tabNameList: [String], viewControllerList: [CVPVCViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.tabNameList = tabNameList
        self.viewControllerList = viewControllerList
        self.initDidAppearFlag = true
        self.pageIdx = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let salg = view.safeAreaLayoutGuide
        
        // コレクションビューの設定や制約は継承クラスにて実施する。
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.setViewControllers(
            [viewControllerList[0]],
            direction: .forward,
            animated: true,
            completion: nil)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewControllerTopAnchor = pageViewController.view.topAnchor
        pageViewController.view.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 0).isActive = true
        pageViewController.view.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: 0).isActive = true
        pageViewControllerBottomAnchor = pageViewController.view.bottomAnchor
        pageViewControllerBottomConstraint = pageViewController.view.bottomAnchor.constraint(equalTo: salg.bottomAnchor, constant: 0)
        pageViewControllerBottomConstraint.isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if initDidAppearFlag {
            self.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
            initDidAppearFlag = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 本クラスはベースクラスのため、下記のコードでの実行を想定しない。
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        pageViewController.setViewControllers(
            [viewControllerList[indexPath.row]],
            direction: pageIdx < indexPath.row ? .forward : .reverse,
            animated: true,
            completion: nil)
        pageIdx = indexPath.row
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = viewControllerList.firstIndex(of: viewController as! CVPVCViewController), index > 0 {
            return viewControllerList[index - 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = viewControllerList.firstIndex(of: viewController as! CVPVCViewController), index < viewControllerList.count - 1 {
            return viewControllerList[index + 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let viewController = pageViewController.viewControllers?.first as! CVPVCViewController
        collectionView.selectItem(
            at: IndexPath(row: viewController.getIndex(), section: 0),
            animated: true,
            scrollPosition: .centeredHorizontally)
        pageIdx = viewController.getIndex()
    }
    
    @objc func tapAccountButton() {
        print("tapped Account Button.")
    }
    
    @objc func tapPointButton() {
        print("tapped Point Button.")
    }
    
}
