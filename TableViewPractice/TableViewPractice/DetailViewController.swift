//
//  DetailViewController.swift
//  TableViewPractice
//
//  Created by 황예리 on 2023/08/02.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"
    
    //1.
    var data: ToDo? // 식판 그자체를 넘겨줌

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let data else { return }
        
        print(data)
        
    }
    

    

}
