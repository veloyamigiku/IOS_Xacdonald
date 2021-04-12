//
//  CouponItemRepository.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/03/04.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

enum CouponItemRepositoryError : Error {
    case cantParseJson
    case failure
}

class CouponItemRepository {
    
    private var db: DisposeBag
    private var couponItemSubject: PublishSubject<[CouponItem]>
    
    
    init() {
        db = DisposeBag()
        couponItemSubject = PublishSubject()
    }
    
    func getCouponItem(categoryID: String) -> Observable<[CouponItem]> {
        
        let couponItemObserver = couponItemSubject.asObserver()
        HttpGet.exec(
            url: ModelConstant.ITEM_SEARCH_URL,
            query: [
                "appid": ModelConstant.APP_ID,
                "genre_category_id": categoryID,
                "image_size": "300",
                "sort": "+price",
                "results": "10",
                "condition": "new",
                "is_discount": "true"
            ]).subscribe(
                onNext: { data in
                    do {
                        let json = try JSON(data: data)
                        let jsonHits = json["hits"]
                        var couponItems: [CouponItem] = []
                        for (_, jsonHit) in jsonHits {
                            couponItems.append(CouponItem(
                                                name: jsonHit["name"].stringValue,
                                                description: jsonHit["description"].stringValue,
                                                price: jsonHit["price"].intValue,
                                                imageUrl: jsonHit["exImage"]["url"].stringValue))
                        }
                        self.couponItemSubject.onNext(couponItems)
                    } catch let jsonError {
                        print(jsonError)
                        self.couponItemSubject.onError(CouponItemRepositoryError.cantParseJson)
                    }
                },
                onError: { error in
                    print(error)
                    self.couponItemSubject.onError(CouponItemRepositoryError.failure)
                }).disposed(by: db)
        
        return couponItemObserver
    }
    
}
