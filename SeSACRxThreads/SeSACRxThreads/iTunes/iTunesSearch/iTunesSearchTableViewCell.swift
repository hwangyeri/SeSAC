//
//  iTunesSearchTableViewCell.swift
//  SeSACRxThreads
//
//  Created by Yeri Hwang on 2023/11/06.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class iTunesSearchTableViewCell: UITableViewCell {
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 16
        return button
    }()
    
    let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "star.fill")
        return imageView
    }()
    
    let appRateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    let sellerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.isLayoutMarginsRelativeArrangement = true
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 8
        return view
    }()
    
    let screenshotImageView1: UIImageView = {
        let imageView = ScreenshotImageView()
        return imageView
    }()
    
    let screenshotImageView2: UIImageView = {
        let imageView = ScreenshotImageView()
        return imageView
    }()
    
    let screenshotImageView3: UIImageView = {
        let imageView = ScreenshotImageView()
        return imageView
    }()
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        [appIconImageView, appNameLabel, downloadButton, starImageView, appRateLabel, sellerNameLabel, genreLabel, stackView].forEach {
            contentView.addSubview($0)
        }
        
        [screenshotImageView1, screenshotImageView2, screenshotImageView3].forEach {
            stackView.addArrangedSubview($0)
        }
        
        appIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(10)
            $0.size.equalTo(60)
        }
        
        appNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-8)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
        
        starImageView.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(2)
            make.size.equalTo(22)
        }
        
        appRateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starImageView)
            make.leading.equalTo(starImageView.snp.trailing).offset(3)
        }
        
        sellerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appRateLabel)
            make.centerX.equalToSuperview()
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(appRateLabel)
            make.trailing.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(starImageView.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }

}
