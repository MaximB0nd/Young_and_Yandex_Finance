//
//  AnaliticsViewController.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.07.2025.
//

import UIKit

class AnaliticsViewController: UIViewController {
    
    lazy var PageTitle: UILabel = { label in
        label.text = "Hello, World!"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        label.frame = CGRect(x: 50, y: 200, width: view.frame.width-100, height: 100)
        
        return label
    }(UILabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        view.addSubview(PageTitle)
        
    }
}
