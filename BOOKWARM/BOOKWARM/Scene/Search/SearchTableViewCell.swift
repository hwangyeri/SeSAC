//
//  BookTableViewCell.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/08/09.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCe"
    
    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        authorLabel.font = .systemFont(ofSize: 14)
        authorLabel.textColor = .lightGray
        authorLabel.numberOfLines = 0
        
        contentLabel.font = .systemFont(ofSize: 13)
        contentLabel.textColor = .black
        contentLabel.numberOfLines = 0
    }


}
