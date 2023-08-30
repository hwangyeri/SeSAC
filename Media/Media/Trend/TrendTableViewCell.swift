//
//  TrendTableViewCell.swift
//  Media
//
//  Created by 황예리 on 2023/08/12.
//

import UIKit

class TrendTableViewCell: BaseTableViewCell {
    
    let dateLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        view.textColor = .darkGray
        return view
    }()
    
    let genreLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 15)
        view.textColor = .black
        return view
    }()
    
    let squareView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 12
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 12
        view.layer.shadowOffset = CGSize(width: 10, height: 10)
        return view
    }()
    
    let mainImageView = {
        let view = UIImageView()
        return view
    }()
    
    let shareButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "paperclip.circle.fill"), for: .normal)
        view.tintColor = .black
        return view
    }()
    
    let rateLabel = {
        let view = RateLabel()
        view.textColor = .white
        view.backgroundColor = .systemIndigo
        view.text = "평점"
        return view
    }()
    
    let rateNumberLabel = {
        let view = RateLabel()
        view.textColor = .black
        view.backgroundColor = .white
        return view
    }()
    
    let originalTitleLabel = {
        let view = ContentLabel()
        view.font = .boldSystemFont(ofSize: 17)
        return view
    }()
    
    let titleLabel = {
        let view = ContentLabel()
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let castLabel = {
        let view = ContentLabel()
        view.font = .boldSystemFont(ofSize: 14)
        return view
    }()
    
    let dividerView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let detailLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        view.text = "자세히 보기"
        view.textColor = .black
        return view
    }()
    
    let chevronImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        return view
    }()
        
    override func configureView() {
        [dateLabel, genreLabel, squareView, mainImageView, shareButton, rateLabel, rateNumberLabel, originalTitleLabel, titleLabel, castLabel, dividerView, dateLabel, chevronImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        dateLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).inset(10)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
        }
        
        squareView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(8)
            make.leading.trailing.bottomMargin.equalTo(10)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(squareView)
            make.top.equalTo(squareView.snp.top)
            make.height.equalTo(squareView).multipliedBy(0.55)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(squareView).inset(10)
            make.size.equalTo(35)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.leading.bottom.equalTo(mainImageView).inset(10)
        }
        
        rateNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(rateLabel.snp.trailing)
            make.top.bottom.equalTo(rateLabel)
            make.size.equalTo(rateLabel)
        }
        
        originalTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(10)
            make.leading.equalTo(rateLabel)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(originalTitleLabel.snp.trailing).offset(8)
            make.top.equalTo(originalTitleLabel)
        }
        
        castLabel.snp.makeConstraints { make in
            make.leading.equalTo(originalTitleLabel)
            make.top.equalTo(originalTitleLabel.snp.bottom).offset(8)
        }
        
        dividerView.snp.makeConstraints { make in
            make.width.equalTo(squareView).multipliedBy(0.9)
            make.height.equalTo(1)
            make.leading.equalTo(castLabel)
            make.top.equalTo(castLabel.snp.bottom).offset(8)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(8)
            make.leading.equalTo(castLabel)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.top.equalTo(detailLabel)
            make.trailing.equalTo(squareView).inset(10)
            make.size.equalTo(35)
        }
        
    }
    
    
}
