//
//  TrandTableViewCell.swift
//  Media
//
//  Created by 황예리 on 2023/08/12.
//

import UIKit

class TrandTableViewCell: UITableViewCell {

    @IBOutlet var listButton: UIButton!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var squareView: UIView!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var rateNumberLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var castLabel: UILabel!
    @IBOutlet var dividerView: UIView!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var chevronImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        listButton.setImage(UIImage(systemName: "list.triangle"), for: .normal)
        listButton.setTitle("", for: .normal)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.setTitle("", for: .normal)
        
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textColor = .darkGray
        genreLabel.font = .boldSystemFont(ofSize: 15)
        genreLabel.textColor = .black
        
        squareView.backgroundColor = .clear
        squareView.layer.cornerRadius = 12
        squareView.layer.shadowOpacity = 0.5
        squareView.layer.shadowRadius = 12
        squareView.layer.shadowOffset = CGSize(width: 10, height: 10)
       
        var config = UIButton.Configuration.filled()
        config.title = .none
        config.image = UIImage(systemName: "paperclip.circle.fill")?.withRenderingMode(.alwaysTemplate)
        config.cornerStyle = .capsule
        
        config.baseBackgroundColor = .cyan
        config.baseForegroundColor = .black
        config.imagePadding = 0
        
        shareButton.configuration = config
//        shareButton.setImage(UIImage(systemName: "paperclip.circle.fill"), for: .normal)
//        shareButton.setTitle("", for: .normal)
        
        rateLabel.font = .systemFont(ofSize: 13)
        rateLabel.textAlignment = .center
        rateLabel.textColor = .white
        rateLabel.text = "평점"
        rateLabel.backgroundColor = .systemIndigo
        rateNumberLabel.font = .systemFont(ofSize: 13)
        rateNumberLabel.textColor = .black
        rateNumberLabel.backgroundColor = .white
        rateNumberLabel.textAlignment = .center
        
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.textColor = .black
        castLabel.font = .systemFont(ofSize: 14)
        castLabel.textColor = .darkGray
        
        dividerView.backgroundColor = .black
        detailLabel.font = .systemFont(ofSize: 13)
        detailLabel.text = "자세히 보기"
        detailLabel.textColor = .black
        chevronImageView.image = UIImage(systemName: "chevron.right")
    }

    
}
