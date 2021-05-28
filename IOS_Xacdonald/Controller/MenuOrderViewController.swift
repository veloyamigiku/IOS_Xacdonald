//
//  MenuOrderViewController.swift
//  IOS_Xacdonald
//
//  Created by velo.yamigiku on 2021/05/28.
//  Copyright © 2021 velo.yamigiku. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MenuOrderViewController: UIViewController {
    
    private var menuItem: MenuItem!
    
    private var disposeBag: DisposeBag!
    
    init(menuItem: MenuItem) {
        super.init(nibName: nil, bundle: nil)
        self.menuItem = menuItem
        self.disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let salg = view.safeAreaLayoutGuide
        
        let addCartButton = UIButton()
        addCartButton.translatesAutoresizingMaskIntoConstraints = false
        let addCartStr = NSAttributedString(
            string: "カートに追加",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)])
        addCartButton.setAttributedTitle(addCartStr, for: .normal)
        addCartButton.backgroundColor = UIColor.init(hex: "ffcc33")
        addCartButton.layer.cornerRadius = 5
        addCartButton.layer.borderWidth = 1
        addCartButton.layer.borderColor = UIColor.init(hex: "ffcc33").cgColor
        addCartButton.rx.tap.subscribe(
            onNext: {
            }).disposed(by: disposeBag)
        view.addSubview(addCartButton)
        addCartButton.topAnchor.constraint(equalTo: salg.topAnchor, constant: 10).isActive = true
        addCartButton.leadingAnchor.constraint(equalTo: salg.leadingAnchor, constant: 10).isActive = true
        addCartButton.trailingAnchor.constraint(equalTo: salg.trailingAnchor, constant: -10).isActive = true
        
    }

}
