//
//  ModelConstant.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/03/04.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import Foundation

class ModelConstant {
    
    static let ITEM_SEARCH_URL = "https://shopping.yahooapis.jp/ShoppingWebService/V3/itemSearch"
    static let KEYWORD_RANKING_URL = "https://shopping.yahooapis.jp/ShoppingWebService/V1/json/queryRanking"
    static let LOCAL_SEARCH_URL = "https://map.yahooapis.jp/search/local/V1/localSearch"
    static let APP_ID = "dj00aiZpPWVheHgxT3VmSmp0eSZzPWNvbnN1bWVyc2VjcmV0Jng9YzU-"
    
    static let CATEGORY_ID_PS5 = "50798"
    static let CATEGORY_ID_XBOX_SERIES_X_S = "50803"
    static let CATEGORY_ID_PS4 = "50521"
    static let CATEGORY_ID_SW = "50522"
    static let CATEGORY_ID_XBOX_ONE = "50530"
    static let CATEGORY_ID_PS3 = "50528"
    
    static let CATEGORY_PS5 = "PS5"
    static let CATEGORY_XBOX_SERIES_X_S = "XBox Series X/S"
    static let CATEGORY_PS4 = "PS4"
    static let CATEGORY_SW = "Nintendo Switch"
    static let CATEGORY_XBOX_ONE = "XBox One"
    static let CATEGORY_PS3 = "PS3"
    
    static let CATEGORY_FOOD = "食品"
    static let CATEGORY_DEVICE = "スマホ、タブレット、PC"
    static let CATEGORY_HOME_APPLIANCE = "家電"
    static let CATEGORY_FURNITURE = "家具"
    static let CATEGORY_BOOK = "本、雑誌、コミック"
    static let CATEGORY_SPORT = "スポーツ"
    static let CATEGORY_GAME = "ゲーム、おもちゃ"
    
    static let CATEGORY_ID_FOOD = "2498"
    static let CATEGORY_ID_DEVICE = "2502"
    static let CATEGORY_ID_HOME_APPLIANCE = "2505"
    static let CATEGORY_ID_FURNITURE = "2506"
    static let CATEGORY_ID_BOOK = "10002"
    static let CATEGORY_ID_SPORT = "2512"
    static let CATEGORY_ID_GAME = "2511"
    
    static let GENRE_ACTION = "アクション"
    static let GENRE_FPS = "FPS"
    static let GENRE_RPG = "ロールプレイング"
    static let GENRE_ADVENTURE = "アドベンチャー"
    static let GENRE_SHOOTING = "シューティング"
    
    static let MENU_DETAIL_INFO_TAB_DETAIL1 = "詳細情報1"
    static let MENU_DETAIL_INFO_TAB_DETAIL2 = "詳細情報2"
    static let MENU_DETAIL_INFO_TAB_DETAIL3 = "詳細情報3"
    
    static let MENU_DETAIL_INFO_TAB_LIST = [
        MENU_DETAIL_INFO_TAB_DETAIL1,
        MENU_DETAIL_INFO_TAB_DETAIL2,
        MENU_DETAIL_INFO_TAB_DETAIL3
    ]
    
    static let MENU_DETAIL_INFO_TYPE_DETAIL1 = 1
    static let MENU_DETAIL_INFO_TYPE_DETAIL2 = 2
    static let MENU_DETAIL_INFO_TYPE_DETAIL3 = 3
    
    static let MENU_DETAIL_INFO_TYPE_LIST = [
        MENU_DETAIL_INFO_TYPE_DETAIL1,
        MENU_DETAIL_INFO_TYPE_DETAIL2,
        MENU_DETAIL_INFO_TYPE_DETAIL3
    ]
    
    static let MENU_ITEM_DETAIL_HEADER_REVIEW = "レビュー"
    static let MENU_ITEM_DETAIL_ITEM_REVIEW_RATE = "レビュー平均"
    static let MENU_ITEM_DETAIL_ITEM_REVIEW_COUNT = "レビュー件数"
    static let MENU_ITEM_DETAIL_HEADER_POINT = "ポイント"
    static let MENU_ITEM_DETAIL_ITEM_POINT_AMOUNT = "基本ポイント数"
    static let MENU_ITEM_DETAIL_ITEM_POINT_TIMES = "基本ポイント倍率"
    static let MENU_ITEM_DETAIL_ITEM_POINT_BONUS_AMOUNT = "ストアボーナス数"
    static let MENU_ITEM_DETAIL_ITEM_POINT_BONUS_TIMES = "ストアボーナス倍率"
    static let MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_AMOUNT = "プレミアム会員向けの基本ポイント数"
    static let MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_TIMES = "プレミアム会員向けの基本ポイント倍率"
    static let MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_BONUS_AMOUNT = "プレミアム会員向けのストアボーナス数"
    static let MENU_ITEM_DETAIL_ITEM_POINT_PREMIUM_BONUS_TIMES = "プレミアム会員向けのストアボーナス倍率"
    static let MENU_ITEM_DETAIL_HEADER_SELLER = "ストア"
    static let MENU_ITEM_DETAIL_ITEM_SELLER_NAME = "ストア名"
    static let MENU_ITEM_DETAIL_ITEM_SELLER_RATE = "レビュー平均"
    static let MENU_ITEM_DETAIL_ITEM_SELLER_COUNT = "レビュー件数"
}
