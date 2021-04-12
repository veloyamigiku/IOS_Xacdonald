//
//  Item.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2020/12/21.
//  Copyright © 2020 velo.yamigiku. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

enum ItemSearchError : Error {
    case cantParseJson
    case failure
}

class ItemRepository {
    
    private final var itemSearchUrl = "https://shopping.yahooapis.jp/ShoppingWebService/V3/itemSearch"
    private var disposeBag: DisposeBag
    private var lowPriceItemSubject: PublishSubject<[LowPriceItem]>
    private var recommendedItemSubject: PublishSubject<[RecommendedItem]>
    
    init() {
        disposeBag = DisposeBag()
        lowPriceItemSubject = PublishSubject()
        recommendedItemSubject = PublishSubject()
    }
    
    func getLowPriceItem() -> Observable<[LowPriceItem]> {
        
        let observable = lowPriceItemSubject.asObservable()
        HttpGet.exec(
            url: itemSearchUrl,
            query: [
                "appid": "dj00aiZpPWVheHgxT3VmSmp0eSZzPWNvbnN1bWVyc2VjcmV0Jng9YzU-",
                "genre_category_id": "2161",
                "image_size": "300",
                "sort": "+price",
                "results": "10",
                "condition": "new"
            ]).subscribe(
                onNext: { data in
                    do {
                        let json = try JSON(data: data)
                        let jsonItems = json["hits"]
                        var lowPriceItems: [LowPriceItem] = []
                        for (_, jsonItem) in jsonItems {
                            lowPriceItems.append(LowPriceItem(
                                                    url: jsonItem["exImage"]["url"].stringValue))
                        }
                        self.lowPriceItemSubject.onNext(lowPriceItems)
                    } catch let jsonError {
                        print(jsonError)
                        self.lowPriceItemSubject.onError(ItemSearchError.cantParseJson)
                    }
                },
                onError: { err in
                    print(err)
                    self.lowPriceItemSubject.onError(ItemSearchError.failure)
                }).disposed(by: disposeBag)
        
        return observable
    }
    
    func getRecommendedItem() -> Observable<[RecommendedItem]> {
        
        let observable = recommendedItemSubject.asObservable()
        HttpGet.exec(
            url: itemSearchUrl,
            query: [
                "appid": "dj00aiZpPWVheHgxT3VmSmp0eSZzPWNvbnN1bWVyc2VjcmV0Jng9YzU-",
                "is_discounted": "true",
                "genre_category_id": "2161",
                "image_size": "106",
                "sort": "-score",
                "results": "4",
                "condition": "new"
            ]).subscribe(
            onNext: { data in
                do {
                    let json = try JSON(data: data)
                    let jsonItems = json["hits"]
                    var recommendedItems: [RecommendedItem] = []
                    for (_, jsonItem) in jsonItems {
                        recommendedItems.append(RecommendedItem(
                                                    name: jsonItem["name"].stringValue,
                                                    price: jsonItem["price"].intValue,
                                                    imageUrl: jsonItem["exImage"]["url"].stringValue))
                    }
                    self.recommendedItemSubject.onNext(recommendedItems)
                } catch let jsonError {
                    print(jsonError)
                    self.recommendedItemSubject.onError(ItemSearchError.cantParseJson)
                }
            },
            onError: { err in
                print(err)
                self.recommendedItemSubject.onError(ItemSearchError.failure)
            }).disposed(by: disposeBag)
        
        return observable
    }
    
}
