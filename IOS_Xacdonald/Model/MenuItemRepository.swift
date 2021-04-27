//
//  MenuItemRepository.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/04/12.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class MenuItemRepository {
    
   static func getKeywordRanking(categoryID: String) -> Observable<[KeywordRanking]> {
        let subject = PublishSubject<[KeywordRanking]>()
        let observable = subject.asObserver()
        HttpGet.exec(
            url: ModelConstant.KEYWORD_RANKING_URL,
            query: [
                "appid": ModelConstant.APP_ID,
                "category_id": categoryID,
                "hits": "5"
            ]).subscribe(
                onNext: { data in
                    do {
                        let json = try JSON(data: data)
                        let totalResultsReturned = json["ResultSet"]["totalResultsReturned"].intValue
                        //print(json["ResultSet"]["0"]["Result"]["0"]["_attributes"])
                        var keywordList: [KeywordRanking] = []
                        for i in 0 ..< totalResultsReturned {
                            keywordList.append(
                                KeywordRanking(
                                    keyword: json["ResultSet"]["0"]["Result"][String(i)]["Query"].stringValue,
                                    ranking: json["ResultSet"]["0"]["Result"][String(i)]["_attributes"]["rank"].intValue))
                        }
                        subject.onNext(keywordList)
                        subject.onCompleted()
                    } catch let jsonError {
                        print(jsonError)
                        subject.onError(jsonError)
                    }
                },
                onError: { error in
                    print(error)
                    subject.onError(error)
                },
                onCompleted: {
                    print("===MenuItemRepository complete===")
                },
                onDisposed: {
                    print("===MenuItemRepository disposed===")
                })
        return observable
    }
    
    static func getMenuItemsWithKeywordRanking(categoryID: String, keywordRanking: KeywordRanking) -> Observable<MenuItemsWithKeywordRanking> {
        let subject = PublishSubject<MenuItemsWithKeywordRanking>()
        let observable = subject.asObserver()
        HttpGet.exec(
            url: ModelConstant.ITEM_SEARCH_URL,
            query: [
                "appid": ModelConstant.APP_ID,
                "genre_category_id": categoryID,
                "image_size": "300",
                "sort": "-score",
                "results": "10",
                "condition": "new",
                "is_discount": "true",
                "query": keywordRanking.keyword
            ]).subscribe(
                onNext: { data in
                    do {
                        let json = try JSON(data: data)
                        let jsonHits = json["hits"]
                        var menuItems: [MenuItem] = []
                        for (_, jsonHit) in jsonHits {
                            menuItems.append(MenuItem(
                                                imageUrl: jsonHit["exImage"]["url"].stringValue,
                                                name: jsonHit["name"].stringValue,
                                                description: jsonHit["description"].stringValue,
                                                price: jsonHit["price"].intValue))
                        }
                        let menuItemsWithKeywordRanking = MenuItemsWithKeywordRanking(
                            MenuItems: menuItems,
                            keywordRanking: keywordRanking)
                        print("===MenuItemRepository next===")
                        subject.onNext(menuItemsWithKeywordRanking)
                        subject.onCompleted()
                    } catch let jsonError {
                        print(jsonError)
                        subject.onError(RepositoryError.cantParseJson)
                    }
                },
                onError: { error in
                    print(error)
                    subject.onError(RepositoryError.failuer)
                },
                onCompleted: {
                    print("===MenuItemRepository complete===")
                },
                onDisposed: {
                    print("===MenuItemRepository disposed===")
                })
        
        return observable
    }
    
}
