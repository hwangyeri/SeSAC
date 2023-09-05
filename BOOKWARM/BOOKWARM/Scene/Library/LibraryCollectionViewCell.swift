//
//  BOOKWARMCollectionViewCell.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {

    @IBOutlet var backView: UIView!
    @IBOutlet var mainTitleLable: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var subTitleLable: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        
        backView.layer.cornerRadius = 20
        mainTitleLable.textColor = .white
        mainTitleLable.font = .boldSystemFont(ofSize: 15)
        mainTitleLable.numberOfLines = 0
        posterImageView.layer.cornerRadius = 8
        subTitleLable.textColor = .white
        subTitleLable.font = .systemFont(ofSize: 13)
        subTitleLable.numberOfLines = 0
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        likeButton.setTitle("", for: .normal)
        likeButton.tintColor = .systemPink
    }
    
//    func configureCell(row: BookTable) {
//        
//        if row.bookLiked {
//            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        } else {
//            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
//        }
//    }
    
}
