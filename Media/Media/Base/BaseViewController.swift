//
//  BaseViewController.swift
//  Media
//
//  Created by 황예리 on 2023/08/28.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    func configureView() { //addSubView
        view.backgroundColor = .white
        print("Base configureView")
    }
    
    func setConstraints() { //제약조건
        print("Base setConstraints")

    }

    
}
