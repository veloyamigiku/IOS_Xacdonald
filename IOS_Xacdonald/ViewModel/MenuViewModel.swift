//
//  MenuViewModel.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/04/04.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import Foundation
import RxSwift

class MenuViewModel {
    
    func getMenuItemWithKeywordRanking(catetoryID: String) -> Observable<[MenuItemsWithKeywordRanking]> {
        let subject = PublishSubject<[MenuItemsWithKeywordRanking]>()
        let observable = subject.asObserver()
        MenuItemRepository.getKeywordRanking(categoryID: catetoryID)
            .flatMap({ keywordRanking -> Observable<[MenuItemsWithKeywordRanking]> in
                var observableList: [Observable<MenuItemsWithKeywordRanking>] = []
                for kr in keywordRanking {
                    let observable = MenuItemRepository.getMenuItemsWithKeywordRanking(
                        categoryID: catetoryID,
                        keywordRanking: kr)
                    observableList.append(observable)
                }
                return Observable.zip(observableList)
            }).subscribe(
                onNext: { menuItemsWithKeywordRanking in
                    print("===MenuViewModel next===")
                    subject.onNext(menuItemsWithKeywordRanking)
                    subject.onCompleted()
                },
                onError: { error in
                    print("===MenuViewModel error===")
                    print(error)
                    subject.onError(error)
                },
                onCompleted: {
                    print("===MenuViewModel complete===")
                },
                onDisposed: {
                    print("===MenuViewModel dispose===")
                })
        return observable
    }
    
}
