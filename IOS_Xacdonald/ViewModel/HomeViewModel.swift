//
//  HomeViewModel.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/02/22.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    private var disposeBag: DisposeBag
    private var subject: PublishSubject<[Any]>
    private var itemRepository: ItemRepository
    
    init() {
        disposeBag = DisposeBag()
        subject = PublishSubject()
        itemRepository = ItemRepository()
    }
    
    func getItem() -> Observable<[Any]> {
        let lowPriceItemObservable = itemRepository.getLowPriceItem()
        let recommendedItemObservable = itemRepository.getRecommendedItem()
        Observable.zip(
            lowPriceItemObservable,
            recommendedItemObservable).subscribe(
                onNext: { (lowPriceItems, recommendedItems) in
                    print("===onNext===")
                    var items: [Any] = lowPriceItems
                    let recommendedItemSet = RecommendedItemSet(items: recommendedItems)
                    items.insert(recommendedItemSet, at: 1)
                    self.subject.onNext(items)
                },
                onError: { err in
                    print("===err===")
                    print(err)
                    self.subject.onError(err)
                },
                onCompleted: {
                    print("===complete===")
                },
                onDisposed: {
                    print("===dispose===")
                }).disposed(by: disposeBag)
        return subject.asObserver()
    }
}
