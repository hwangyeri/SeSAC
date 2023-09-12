//
//  JoinTextField.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/25.
//

import UIKit

class JoinTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupView() {
        borderStyle = .none
        layer.cornerRadius = 6
        textColor = .white
        textAlignment = .center
        font = .boldSystemFont(ofSize: 13)
        backgroundColor = .darkGray
    }
    
}
