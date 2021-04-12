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
    
    func getMenuItemWithKeywordRanking(catetoryID: String) -> Observable<[[MenuItem]]> {
        let subject = PublishSubject<[[MenuItem]]>()
        let observable = subject.asObserver()
        MenuItemRepository.getKeywordRanking(categoryID: catetoryID)
            .flatMap({ keyword -> Observable<[[MenuItem]]> in
                var observableList: [Observable<[MenuItem]>] = []
                for k in keyword {
                    let observable = MenuItemRepository.getMenuItem(
                        categoryID: catetoryID,
                        query: k)
                    observableList.append(observable)
                }
                return Observable.zip(observableList)
            }).subscribe(
                onNext: { menuItem in
                    print("===MenuViewModel next===")
                    subject.onNext(menuItem)
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
