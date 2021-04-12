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
    
   static func getKeywordRanking(categoryID: String) -> Observable<[String]> {
        let subject = PublishSubject<[String]>()
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
                        var keywordList: [String] = []
                        for i in 0 ..< totalResultsReturned {
                            keywordList.append(json["ResultSet"]["0"]["Result"][String(i)]["Query"].stringValue)
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
    
    static func getMenuItem(categoryID: String, query: String) -> Observable<[MenuItem]> {
        let subject = PublishSubject<[MenuItem]>()
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
                "query": query
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
                                                price: jsonHit["price"].intValue))
                        }
                        print("===MenuItemRepository next===")
                        subject.onNext(menuItems)
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
