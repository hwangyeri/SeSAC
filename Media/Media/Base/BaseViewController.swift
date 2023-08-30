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
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func setConstraints() { }

    
}
