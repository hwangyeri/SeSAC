//
//  RecentCollectionViewCell.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/08/02.
//

import UIKit

class RecentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecentCollectionViewCell"
    
    var selectedMovie: Movie?
    var naviTitle: String?
    
    @IBOutlet var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        posterImageView.contentMode = .scaleAspectFill
        //FIXME: - cornerRadius
        posterImageView.layer.cornerRadius = 20
    }
    
    func configureCell(row: Movie) {
        posterImageView.image = UIImage(named: row.imageName)
    }
    
}
