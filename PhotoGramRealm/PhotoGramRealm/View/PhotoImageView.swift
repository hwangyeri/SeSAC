//
//  PhotoImageView.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit

final class PhotoImageView: UIImageView { // final 더이상 상속이 안될거야 ~
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = Constants.Desgin.cornerRadius
        layer.borderWidth = Constants.Desgin.borderWidth
        layer.borderColor = Constants.BaseColor.border
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
