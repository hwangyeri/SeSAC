//
//  TopButton.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/25.
//

import UIKit

class TopButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        tintColor = .white
        titleLabel?.font = .boldSystemFont(ofSize: 15)
    }
    
    
}
