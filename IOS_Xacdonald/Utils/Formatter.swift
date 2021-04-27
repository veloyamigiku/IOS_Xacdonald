//
//  Formatter.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/04/17.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import Foundation

class Formatter {
    
    static func formatForPrice(number: Int) -> String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.groupingSeparator = ","
        f.groupingSize = 3
        return f.string(from: NSNumber(integerLiteral: number)) ?? "\(number)"
    }
    
}
