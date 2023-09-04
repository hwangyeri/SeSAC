//
//  SearchCollectionViewCell.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/08/04.
//

import UIKit

class MySearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var backView: UIView!
    @IBOutlet var mainTitleLable: UILabel!
    @IBOutlet var subTitleLable: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        backView.backgroundColor = .white
        backView.layer.borderColor = UIColor.black.cgColor
        backView.layer.borderWidth = 0.5
        
        mainTitleLable.textColor = .black
        mainTitleLable.font = .boldSystemFont(ofSize: 15)
        
        subTitleLable.textColor = .darkGray
        subTitleLable.font = .boldSystemFont(ofSize: 12)
    }
}
