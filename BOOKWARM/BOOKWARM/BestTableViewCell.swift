//
//  BestTableViewCell.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/08/02.
//

import UIKit

class BestTableViewCell: UITableViewCell {
    
    static let identifier = "BestTableViewCell"
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var mainLable: UILabel!
    @IBOutlet var subLable: UILabel!
    @IBOutlet var watchaImageView: UIImageView!
    @IBOutlet var netflixImageView: UIImageView!
    
    override func awakeFromNib() {
        // 정적인 디자인
        mainLable.font = .boldSystemFont(ofSize: 15)
        mainLable.textColor = .darkGray
        
        subLable.font = .boldSystemFont(ofSize: 13)
        subLable.textColor = .lightGray
        
        symbolStyle(symbol: watchaImageView, ott: "Watcha")
        symbolStyle(symbol: netflixImageView, ott: "Watcha")
    }
    
    func configureCell(row: Movie) {
        
        var subLableText: String {
            get {
                let yearIndex = row.releaseDate.index(row.releaseDate.startIndex, offsetBy: 4)
                let year = row.releaseDate.prefix(upTo: yearIndex)
                return "\(year) ∙ 영화"
            }
        }
        
        posterImageView.image = UIImage(named: row.imageName)
        //FIXME: - cornerRadius
        posterImageView.layer.cornerRadius = 5
        posterImageView.contentMode = .scaleAspectFill
        
        mainLable.text = row.title
        subLable.text = subLableText
        
    }
    
    func symbolStyle(symbol: UIImageView, ott: String) {
        symbol.image = UIImage(named: ott)
        symbol.layer.cornerRadius = 5
        symbol.layer.borderColor = UIColor.lightGray.cgColor
        symbol.layer.borderWidth = 0.5
        symbol.layer.backgroundColor = UIColor.white.cgColor
        symbol.contentMode = .scaleAspectFill
    }
    
    
}
