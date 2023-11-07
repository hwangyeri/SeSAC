//
//  ScreenshotImageView.swift
//  SeSACRxThreads
//
//  Created by Yeri Hwang on 2023/11/07.
//

import UIKit

final class ScreenshotImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        
        contentMode = .scaleAspectFit
        clipsToBounds = true
        layer.cornerRadius = 16
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
