//
//  BottomButton.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/28.
//

import UIKit

class BottomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        tintColor = .white
        //FIXME: - setTitle size
        var config = UIButton.Configuration.plain()
        config.imagePlacement = NSDirectionalRectEdge.top
        config.imagePadding = 10
        self.configuration = config
    }
    
    
}
