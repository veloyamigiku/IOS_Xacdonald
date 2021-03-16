//
//  String.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/03/15.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

extension String {
    
    private func sizeOfString(font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        return (self as NSString).size(withAttributes: attributes)
    }
    
    public func widthOfString(font: UIFont) -> CGFloat {
        return sizeOfString(font: font).width
    }
    
    public func heightOfString(font: UIFont) -> CGFloat {
        return sizeOfString(font: font).height
    }
}
