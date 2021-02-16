//
//  Item.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2020/12/21.
//  Copyright © 2020 velo.yamigiku. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import SwiftyJSON

class ItemRepository {
    
    private var disposeBag: DisposeBag
    private var recommendedItemRelay: PublishRelay<[RecommendedItem]>
    
    init() {
        disposeBag = DisposeBag()
        recommendedItemRelay = PublishRelay()
    }
    
    func getRecommendedItem() -> Observable<[RecommendedItem]> {
        
        let observable = recommendedItemRelay.asObservable()
        
        let httpGet = HttpGet()
        httpGet.exec(
            url: "https://shopping.yahooapis.jp/ShoppingWebService/V3/itemSearch",
            query: [
                "appid": "dj00aiZpPWVheHgxT3VmSmp0eSZzPWNvbnN1bWVyc2VjcmV0Jng9YzU-",
                "is_discounted": "true",
                "genre_category_id": "2161",
                "image_size": "300",
                "sort": "-score",
                "results": "10"
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
                    self.recommendedItemRelay.accept(recommendedItems)
                } catch let jsonError {
                    print(jsonError)
                    self.recommendedItemRelay.accept([])
                }
            },
            onError: { err in
                print(err)
                self.recommendedItemRelay.accept([])
            }).disposed(by: disposeBag)
        
        return observable
    }
    
}
