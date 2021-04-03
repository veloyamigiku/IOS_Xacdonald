//
//  MenuViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/04/03.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit

class MenuViewController: CVPVCViewController {
    
    private var menu: Menu!
    
    init(menu: Menu, index: Int) {
        super.init(index: index)
        self.menu = menu
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
    
}
