//
//  contentLabel.swift
//  SeSACWeek10
//
//  Created by 황예리 on 2023/09/20.
//

import UIKit

final class BeerLabel: UILabel {
    
    init(fontSize: CGFloat, textColor: UIColor) {
        super.init(frame: .zero)
        
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = textColor
        self.numberOfLines = 0
        self.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
