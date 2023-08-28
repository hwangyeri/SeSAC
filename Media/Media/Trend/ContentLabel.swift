//
//  ContentLabel.swift
//  Media
//
//  Created by 황예리 on 2023/08/28.
//

import UIKit

class ContentLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        textColor = .darkGray
    }
    
    
}
