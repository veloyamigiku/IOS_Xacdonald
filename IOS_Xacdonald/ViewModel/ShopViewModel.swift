//
//  ShopViewModel.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/04/30.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import Foundation
import RxSwift

class ShopViewModel {
    
    func getShop(lat: Float, lon: Float, query: String) -> Observable<[Shop]> {
        let subject = PublishSubject<[Shop]>()
        let observable = subject.asObserver()
        ShopRepository.getShop(lat: lat, lon: lon, query: query)
            .subscribe(
                onNext: { shopList in
                    print("===ShopViewModel next===")
                    subject.onNext(shopList)
                    subject.onCompleted()
                },
                onError: { error in
                    print("===ShopViewModel error")
                    print(error)
                    subject.onError(error)
                },
                onCompleted: {
                    print("===ShopViewMode completed")
                },
                onDisposed: {
                    print("===ShopViewModel disposed")
                })
        return observable
    }
}
