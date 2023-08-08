//
//  BeerTableViewCell.swift
//  SeSACWeek3
//
//  Created by 황예리 on 2023/08/08.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    
    static let identifier = "BeerTableViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var beerNameLabel: UILabel!
    @IBOutlet var beerInfoLabel: UILabel!
    @IBOutlet var randomButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.text = "오늘은 이 맥주를 추천드려요!"
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.textColor = .black
        
        beerInfoLabel.textAlignment = .center
        beerInfoLabel.numberOfLines = 0
        beerInfoLabel.font = .systemFont(ofSize: 13)
        beerInfoLabel.textColor = .black
        
        beerNameLabel.font = .boldSystemFont(ofSize: 15)
        beerNameLabel.textColor = .black
        beerNameLabel.textAlignment = .center
        beerNameLabel.numberOfLines = 0
        
        randomButton.tintColor = .systemOrange
        var config = UIButton.Configuration.plain()
        
        config.title = "다른 맥주 추천받기"
        config.image = UIImage(systemName: "t.bubble.he")
        config.imagePadding = 8
        
        randomButton.configuration = config
        
    }
    
}
