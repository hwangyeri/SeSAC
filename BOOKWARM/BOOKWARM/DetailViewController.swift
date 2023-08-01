//
//  DetailViewController.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var mainLable: UILabel!
    
    var naviTitle: String = "navi Title"
    var detailLable: String = "상세 화면"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        let chevron = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: chevron, style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black

        title = naviTitle
        mainLable.text = detailLable
        mainLable.font = .systemFont(ofSize: 32)
        mainLable.textAlignment = .center
        
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
   
}
