//
//  ProfileButton.swift
//  Media
//
//  Created by 황예리 on 2023/08/29.
//

import UIKit

class ProfileButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let config = UIButton.Configuration.plain()
        tintColor = .lightGray
        contentHorizontalAlignment = .left
        self.configuration = config
    }
    
    
}

