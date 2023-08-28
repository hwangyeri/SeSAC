//
//  CircleImageView.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/28.
//

import UIKit

class CircleImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        print(frame.width, frame)
        backgroundColor = .yellow
        layer.borderColor = UIColor.systemYellow.cgColor
        layer.borderWidth = 1
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubView", frame.width, frame)
        layer.cornerRadius = frame.width / 2
    }
    
    
}

