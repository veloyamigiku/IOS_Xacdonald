//
//  CVPVCViewControllerA.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/16.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class CVPVCViewControllerA: CVPVCBaseViewController {

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
        
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionView.backgroundColor = .clear
        collectionView.register(
            CVPVCCollectionViewCellA.self,
            forCellWithReuseIdentifier: "CVPVCCollectionViewCellA")
        collectionView.heightAnchor.constraint(equalToConstant: CVPVCCollectionViewCellA.CELL_HEIGHT).isActive = true
        collectionView.topAnchor.constraint(equalTo: salg.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: 0).isActive = true
        pageViewControllerTopAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CVPVCCollectionViewCellA",
            for: indexPath) as! CVPVCCollectionViewCellA
        cell.label.text = tabNameList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(
            width: tabNameList[indexPath.row].widthOfString(font: UIFont.systemFont(ofSize: CVPVCCollectionViewCellA.LABEL_FONT_SIZE)) + (CVPVCCollectionViewCellA.LABEL_MARGIN_LEFT_RIGHT * 2),
            height: CVPVCCollectionViewCellA.CELL_HEIGHT)
        return size
    }

}
