//
//  DividerView.swift
//  Media
//
//  Created by 황예리 on 2023/08/28.
//

import UIKit

class DividerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        backgroundColor = .lightGray
    }
    
    
}

