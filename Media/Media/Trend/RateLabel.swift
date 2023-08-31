//
//  RateLabel.swift
//  Media
//
//  Created by 황예리 on 2023/08/28.
//

import UIKit

class RateLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        font = .systemFont(ofSize: 13)
        textAlignment = .center
    }
    
    
}
