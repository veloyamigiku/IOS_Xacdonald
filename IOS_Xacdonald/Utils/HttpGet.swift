//
//  HttpGet.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2020/12/21.
//  Copyright © 2020 velo.yamigiku. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class HttpGet {
    
    private static func createQueryItems(query: [String: String]) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        for (queryItemName, queryItemValue) in query {
            queryItems.append(URLQueryItem(name: queryItemName, value: queryItemValue))
        }
        return queryItems
    }
    
    static func exec(url: String, query: [String: String]) -> Observable<Data> {
        let subject = PublishSubject<Data>()
        let observable = subject.asObserver()
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = createQueryItems(query: query)
        let query = urlComponents?.query
        
        // [+]をエンコード対象とする。
        var urlQueryAllowedCs = CharacterSet.urlQueryAllowed
        // クエリ文字列内で許容する[+]を許容対象外（エンコード対象）とする。
        urlQueryAllowedCs.remove("+")
        urlComponents?.percentEncodedQuery = query?.addingPercentEncoding(withAllowedCharacters: urlQueryAllowedCs)
        
        let request = URLRequest(url: (urlComponents?.url)!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            subject.onNext(data)
            subject.onCompleted()
            print(data)
        }.resume()
        
        return observable
    }
    
}
