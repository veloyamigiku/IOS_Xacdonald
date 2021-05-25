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
        collectionView.layer.cornerRadius = 5
        collectionView.backgroundColor = .lightGray
        collectionView.register(
            CVPVCCollectionViewCellB.self,
            forCellWithReuseIdentifier: "CVPVCCollectionViewCellB")
        collectionView.heightAnchor.constraint(equalToConstant: CVPVCCollectionViewCellB.CELL_HEIGHT + 10).isActive = true
        collectionView.topAnchor.constraint(equalTo: salg.topAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -10).isActive = true
        pageViewControllerTopAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true
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
            width: getCellWidth(cellLabel: tabNameList[indexPath.row]),
            height: CVPVCCollectionViewCellB.CELL_HEIGHT)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let cellSpacing = flowLayout.minimumInteritemSpacing
        let cellCount = tabNameList.count
        var totalCellWidth = CGFloat(0)
        for tabName in tabNameList {
            totalCellWidth += getCellWidth(cellLabel: tabName)
        }
        let totalSpacingWidth = cellSpacing * CGFloat(cellCount - 1)
        let collectionViewWidth = collectionView.bounds.size.width
        let inset = (collectionViewWidth - (totalCellWidth + totalSpacingWidth)) / 2
        if inset < 5 {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        } else {
            return UIEdgeInsets(top: 5, left: inset, bottom: 5, right: inset)
        }
    }
    
    private func getCellWidth(cellLabel: String) -> CGFloat {
        return cellLabel.widthOfString(font: UIFont.systemFont(ofSize: CVPVCCollectionViewCellB.LABEL_FONT_SIZE)) + (CVPVCCollectionViewCellB.LABEL_MARGIN_LEFT_RIGHT * 2)
    }
    
}
