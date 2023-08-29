//
//  ProfileLabel.swift
//  Media
//
//  Created by 황예리 on 2023/08/29.
//

import UIKit

class ProfileLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        font = .systemFont(ofSize: 16)
        textAlignment = .left
        textColor = .black
    }
    
    
}
