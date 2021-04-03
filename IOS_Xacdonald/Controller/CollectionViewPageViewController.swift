//
//  CollectionViewPageViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/04/02.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class CollectionViewPageViewController: UIViewController,
                                        UICollectionViewDataSource,
                                        UIPageViewControllerDataSource,
                                        UIPageViewControllerDelegate,
                                        UICollectionViewDelegateFlowLayout {
    
    private var tabNameList: [String]!
    
    private var initDidAppearFlag: Bool!
    
    private var pageIdx: Int!
    
    private var viewControllerList: [CVPVCViewController]!
    
    private var pageViewController: UIPageViewController!
    
    private var collectionView: UICollectionView!
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        if initDidAppearFlag {
            self.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
            initDidAppearFlag = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let salg = view.safeAreaLayoutGuide
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CouponCollectionViewCell.self, forCellWithReuseIdentifier: "CouponCollectionViewCell")
        view.addSubview(collectionView)
        collectionView.heightAnchor.constraint(equalToConstant: CouponCollectionViewCell.CELL_HEIGHT).isActive = true
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
        pageViewController.setViewControllers(
            [viewControllerList[0]],
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
        return tabNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CouponCollectionViewCell",
            for: indexPath) as! CouponCollectionViewCell
        cell.label.text = tabNameList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(
            width: tabNameList[indexPath.row].widthOfString(font: UIFont.systemFont(ofSize: 17)),
            height: CouponCollectionViewCell.CELL_HEIGHT)
        return size
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
