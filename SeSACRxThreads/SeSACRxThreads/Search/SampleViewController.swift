//
//  SampleViewController.swift
//  SeSACRxThreads
//
//  Created by Yeri Hwang on 2023/11/05.
//

import UIKit

class SampleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.title = "\(Int.random(in: 1...100))"
    }
    
}
