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
        view.font = .boldSystemFont(ofSize: 16)
        view.textColor = .black
        return view
    }()
    
    let squareView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 12
        view.layer.shadowOffset = CGSize(width: 10, height: 10)
        return view
    }()
    
    let mainImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let shareButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "paperclip.circle.fill"), for: .normal)
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
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
        let view = UILabel()
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 16)
        view.textColor = .black
        return view
    }()
    
    let castLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 14)
        view.textColor = .darkGray
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
        view.tintColor = .black
        view.contentMode = .scaleAspectFit
        return view
    }()
        
    override func configureView() {
        [dateLabel, genreLabel, squareView, mainImageView, shareButton, rateLabel, rateNumberLabel, originalTitleLabel, titleLabel, castLabel, dividerView, detailLabel, chevronImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        dateLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).inset(20)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
        }
        
        squareView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(squareView)
            make.top.equalTo(squareView.snp.top)
            make.height.equalTo(squareView).multipliedBy(0.7)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(squareView).inset(30)
            make.trailing.equalTo(squareView).inset(5)
            make.size.equalTo(30)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(mainImageView).inset(30)
            make.leading.equalTo(mainImageView).inset(10)
            make.width.equalTo(40)
        }
        
        rateNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(rateLabel.snp.trailing)
            make.top.bottom.equalTo(rateLabel)
            make.height.equalTo(rateLabel)
            make.width.equalTo(45)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom)
            make.leading.equalTo(rateLabel)
            make.trailing.equalTo(mainImageView).inset(20)
            make.bottom.equalTo(castLabel.snp.top)
        }
        
//        originalTitleLabel.snp.makeConstraints { make in
//            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
//            make.top.equalTo(titleLabel)
//        }
        
        castLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(dividerView.snp.top).offset(-8)
            make.trailing.equalTo(mainImageView.snp.trailing).inset(20)
            make.height.equalTo(25)
        }
        
        dividerView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(castLabel)
            make.trailing.equalTo(mainImageView.snp.trailing)
            make.top.equalTo(castLabel.snp.bottom).offset(8)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(8)
            make.leading.equalTo(castLabel)
            make.bottom.equalTo(squareView.snp.bottom).inset(15)
            make.trailing.equalTo(chevronImageView.snp.leading).offset(20)
        }

        chevronImageView.snp.makeConstraints { make in
            make.top.equalTo(detailLabel)
            make.trailing.equalTo(squareView.snp.trailing).inset(10)
            make.size.equalTo(20)
        }
        
    }
    
    
}
