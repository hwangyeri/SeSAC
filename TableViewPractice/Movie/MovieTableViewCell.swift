//
//  MovieTableViewCell.swift
//  TableViewPractice
//
//  Created by 황예리 on 2023/07/28.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let identifier = "MovieTableViewCell"

    
    @IBOutlet var backView: UIView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var mainLable: UILabel!
    @IBOutlet var subLable: UILabel!
    @IBOutlet var overviewLable: UILabel!
    
    
    
    
}
