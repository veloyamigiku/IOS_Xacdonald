//
//  CVPVCViewControllerB.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/24.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class CVPVCViewControllerB: CVPVCBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let salg = view.safeAreaLayoutGuide
        
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.backgroundColor = .clear
        collectionView.register(
            CVPVCCollectionViewCellB.self,
            forCellWithReuseIdentifier: "CVPVCCollectionViewCellB")
        collectionView.heightAnchor.constraint(equalToConstant: CVPVCCollectionViewCellB.CELL_HEIGHT).isActive = true
        collectionView.topAnchor.constraint(equalTo: salg.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: 0).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CVPVCCollectionViewCellB",
            for: indexPath) as! CVPVCCollectionViewCellB
        cell.label.text = tabNameList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(
            width: tabNameList[indexPath.row].widthOfString(font: UIFont.systemFont(ofSize: CVPVCCollectionViewCellB.LABEL_FONT_SIZE)) + (CVPVCCollectionViewCellB.LABEL_MARGIN_LEFT_RIGHT * 2),
            height: CVPVCCollectionViewCellB.CELL_HEIGHT)
        return size
    }

}
