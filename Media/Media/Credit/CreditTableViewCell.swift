//
//  CreditTableViewCell.swift
//  Media
//
//  Created by 황예리 on 2023/08/14.
//

import UIKit

class CreditTableViewCell: UITableViewCell {

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var castNameLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.layer.cornerRadius = 8
        
        castNameLabel.font = .boldSystemFont(ofSize: 15)
        castNameLabel.textColor = .black
        castNameLabel.numberOfLines = 0
        
        subLabel.font = .systemFont(ofSize: 13)
        subLabel.textColor = .lightGray
        subLabel.numberOfLines = 0
    }

    
}
