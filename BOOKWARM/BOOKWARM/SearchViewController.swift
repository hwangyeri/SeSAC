//
//  ViewController.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {
    
    static let identifier = "SearchViewController"
    
    @IBOutlet var mainLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: SearchViewController.identifier, bundle: nil)
        let xmark = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        
        title = "검색 화면"
        mainLable.text = title
        mainLable.font = .systemFont(ofSize: 32)
        mainLable.textAlignment = .center
        
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }

    

}

