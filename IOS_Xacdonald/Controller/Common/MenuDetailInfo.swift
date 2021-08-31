//
//  MenuDetailInfo.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/09/01.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class MenuDetailInfo: NSObject {
    
    static func fromMenuDetailInfoTypeToMenuDetailItemData(menuDetailInfoType: Int, menuItem: MenuItem) -> [MenuItemDetailData] {
        switch menuDetailInfoType {
        case ModelConstant.MENU_DETAIL_INFO_TYPE_DETAIL1:
            let midhReview = MenuItemDetailHeader(label: ModelConstant.MENU_ITEM_DETAIL_HEADER_REVIEW)
            let midiReviewRate = MenuItemDetailItem(
                label: ModelConstant.MENU_ITEM_DETAIL_ITEM_REVIEW_RATE,
                value: String(menuItem.reviewRate))
            let midiReviewCount = MenuItemDetailItem(
                label: ModelConstant.MENU_ITEM_DETAIL_ITEM_REVIEW_COUNT,
                value: String(menuItem.reviewCount))
            return [MenuItemDetailData(
                        menuItemDetailHeader: midhReview,
                        menuItemDetailItems: [
                            midiReviewRate,
                            midiReviewCount])]
        case ModelConstant.MENU_DETAIL_INFO_TYPE_DETAIL2:
            let midhPoint = MenuItemDetailHeader(label: ModelConstant.MENU_ITEM_DETAIL_HEADER_POINT)
            let midiPointAmont = MenuItemDetailItem(
                label: ModelConstant.MENU_ITEM_DETAIL_ITEM_POINT_AMOUNT,
                value: String(menuItem.pointAmount))
            let midiPointTimes = MenuItemDetailItem(
                label: ModelConstant.MENU_ITEM_DETAIL_ITEM_POINT_TIMES,
                value: String(menuItem.pointTimes))
            let midiPointBonusAmount = MenuItemDetailItem(
                label: ModelConstant.MENU_ITEM_DETAIL_ITEM_POINT_BONUS_AMOUNT,
                value: String(menuItem.pointBonusAmount))
            let midiPointBonusTimes = MenuItemDetailItem(
                label: ModelConstant.MENU_ITEM_DETAIL_ITEM_POINT_BONUS_TIMES,
                value: String(menuItem.pointBonusTimes))
            let midiPointPremiumAmount = MenuItemDetailItem(
                label: ModelConstant.MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_AMOUNT,
                value: String(menuItem.pointPremiumAmount))
            let midiPointPremiumTimes = MenuItemDetailItem(
                label: ModelConstant.MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_TIMES,
                value: String(menuItem.pointPremiumTimes))
            let midiPointPremiumBonusAmount = MenuItemDetailItem(
                label: ModelConstant.MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_BONUS_AMOUNT,
                value: String(menuItem.pointPremiumBonusAmount))
            let midiPointPremiumBonusTimes = MenuItemDetailItem(
                label: ModelConstant.MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_BONUS_TIMES,
                value: String(menuItem.pointPremiumBonusTimes))
            return [MenuItemDetailData(
                        menuItemDetailHeader: midhPoint,
                        menuItemDetailItems: [
                            midiPointAmont,
                            midiPointTimes,
                            midiPointBonusAmount,
                            midiPointBonusTimes,
                            midiPointPremiumAmount,
                            midiPointPremiumTimes,
                            midiPointPremiumBonusAmount,
                            midiPointPremiumBonusTimes])]
        case ModelConstant.MENU_DETAIL_INFO_TYPE_DETAIL3:
            let midhSeller = MenuItemDetailHeader(label: ModelConstant.MENU_ITEM_DETAIL_HEADER_SELLER)
            let midiSellerName = MenuItemDetailItem(
                label: ModelConstant.MENU_ITEM_DETAIL_ITEM_SELLER_NAME,
                value: String(menuItem.sellerName))
            let midiSellerReviewRate = MenuItemDetailItem(
                label: ModelConstant.MENU_ITEM_DETAIL_ITEM_SELLER_RATE,
                value: String(menuItem.sellerReviewRate))
            let midiSellerReviewCount = MenuItemDetailItem(
                label: ModelConstant.MENU_ITEM_DETAIL_ITEM_SELLER_COUNT,
                value: String(menuItem.sellerReviewCount))
            return [MenuItemDetailData(
                        menuItemDetailHeader: midhSeller,
                        menuItemDetailItems: [
                            midiSellerName,
                            midiSellerReviewRate,
                            midiSellerReviewCount])]
        default:
            do {
                throw MenuDetailViewControllerError.implementBug
            } catch let error {
                print(error)
                return []
            }
        }
    }
}
