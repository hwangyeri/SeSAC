//
//  CreditTableViewCell.swift
//  Media
//
//  Created by 황예리 on 2023/08/14.
//

import UIKit

//class CreditTableViewCell: UITableViewCell {
//
//    @IBOutlet var posterImageView: UIImageView!
//    @IBOutlet var castNameLabel: UILabel!
//    @IBOutlet var subLabel: UILabel!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        posterImageView.layer.cornerRadius = 8
//
//        castNameLabel.font = .boldSystemFont(ofSize: 15)
//        castNameLabel.textColor = .black
//        castNameLabel.numberOfLines = 0
//
//        subLabel.font = .systemFont(ofSize: 13)
//        subLabel.textColor = .lightGray
//        subLabel.numberOfLines = 0
//    }
//
//
//}

class CreditTableViewCell: BaseTableViewCell {
    
    let posterImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    let castNameLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 15)
        view.textColor = .black
        view.numberOfLines = 0
        return view
    }()
    
    let subLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        view.textColor = .lightGray
        return view
    }()
    
    override func configureView() {
        [posterImageView, castNameLabel, subLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(20)
            make.verticalEdges.equalTo(contentView).inset(10)
            make.width.equalTo(contentView).multipliedBy(0.35)
        }
        
        castNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView).inset(10)
            make.leading.equalTo(posterImageView.snp.trailing).offset(20)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(castNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(castNameLabel)
        }
        
    }
    
    
}
