//
//  ShopRepository.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/04/30.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON
import MapKit

class ShopRepository {
    
    static func getShop(lat: Double, lon: Double, query: String) -> Observable<[Shop]>  {
        let subject = PublishSubject<[Shop]>()
        let observable = subject.asObserver()
        HttpGet.exec(
            url: ModelConstant.LOCAL_SEARCH_URL,
            query: [
                "appid": ModelConstant.APP_ID,
                "lat": String(lat),
                "lon": String(lon),
                "output": "json",
                "query": query,
                "sort": "dist"
            ]).subscribe(
                onNext: { data in
                    do {
                        let json = try JSON(data: data)
                        let total = json["ResultInfo"]["Total"].intValue
                        var shopList: [Shop] = []
                        if total > 0 {
                            let curLocation = CLLocation(latitude: lat, longitude: lon)
                            for feature in json["Feature"].arrayValue {
                                //print(feature)
                                let name = feature["Name"].stringValue
                                let address = feature["Property"]["Address"].stringValue
                                let tel = feature["Property"]["Tel1"].stringValue
                                let coordinate = feature["Geometry"]["Coordinates"].stringValue
                                let coordinateParts = coordinate.split(separator: ",")
                                let shopLat = Double(coordinateParts[1])!
                                let shopLon = Double(coordinateParts[0])!
                                let shopLocation = CLLocation(latitude: shopLat, longitude: shopLon)
                                let dist = Int(shopLocation.distance(from: curLocation))
                                let stationList = feature["Property"]["Station"]
                                var station = ""
                                var railway = ""
                                if stationList.count > 0 {
                                    let s = stationList[0]
                                    station = s["Name"].stringValue
                                    railway = s["Railway"].stringValue
                                }
                                let shop = Shop(
                                    name: name,
                                    address: address,
                                    tel: tel,
                                    station: station,
                                    railway: railway,
                                    lat: shopLat,
                                    lon: shopLon,
                                    dist: dist)
                                //print(shop)
                                shopList.append(shop)
                            }
                        }
                        subject.onNext(shopList)
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
                    print("===ShopRepository completed===")
                },
                onDisposed: {
                    print("===ShopRepository disposed===")
                })
        return observable
    }
}
