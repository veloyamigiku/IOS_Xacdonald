//
//  CVPVCViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/04/04.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class CVPVCViewController: UIViewController {
    
    private var index: Int!
    
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getIndex() -> Int {
        return index
    }
    
}
