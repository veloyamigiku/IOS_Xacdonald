//
//  CouponViewModel.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/03/04.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import Foundation
import RxSwift

class CouponViewModel {
    
    private var disposeBag: DisposeBag
    private var couponItemSubject: PublishSubject<[CouponItem]>
    private var couponItemRepository: CouponItemRepository
    
    init() {
        disposeBag = DisposeBag()
        couponItemSubject = PublishSubject()
        couponItemRepository = CouponItemRepository()
    }
    
    func getCouponItem(categoryID: String) -> Observable<[CouponItem]> {
        couponItemRepository
            .getCouponItem(categoryID: categoryID)
            .subscribe(
                onNext: { couponItems in
                    self.couponItemSubject.onNext(couponItems)
                },
                onError: { error in
                    print(error)
                    self.couponItemSubject.onError(error)
                }).disposed(by: disposeBag)
        return couponItemSubject.asObserver()
    }
}
