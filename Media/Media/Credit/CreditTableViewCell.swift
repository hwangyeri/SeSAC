//
//  CreditTableViewCell.swift
//  Media
//
//  Created by 황예리 on 2023/08/14.
//

import UIKit

class CreditTableViewCell: BaseTableViewCell {
    
    let posterImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFit
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
            make.top.bottom.equalTo(contentView).inset(10)
            make.width.equalTo(contentView).multipliedBy(0.35)
        }
        
        castNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView).offset(-15)
            make.leading.equalTo(posterImageView.snp.trailing).offset(20)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(castNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(castNameLabel)
        }
        
    }
    
    
}
