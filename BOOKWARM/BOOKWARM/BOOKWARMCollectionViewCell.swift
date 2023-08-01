//
//  BOOKWARMCollectionViewCell.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit

class BOOKWARMCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BOOKWARMCollectionViewCell"

    @IBOutlet var backView: UIView!
    @IBOutlet var mainTitleLable: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var subTitleLable: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    func configureLikeButton(row: Movie) {
        if row.like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
}
