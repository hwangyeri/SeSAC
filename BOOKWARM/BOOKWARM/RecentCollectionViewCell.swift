//
//  RecentCollectionViewCell.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/08/02.
//

import UIKit

class RecentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecentCollectionViewCell"
    
    @IBOutlet var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        posterImageView.contentMode = .scaleAspectFit
        //FIXME: - cornerRadius
        posterImageView.layer.cornerRadius = 20
    }
    
    func configureCell(row: Movie) {
        posterImageView.image = UIImage(named: row.imageName)
    }
    
}
