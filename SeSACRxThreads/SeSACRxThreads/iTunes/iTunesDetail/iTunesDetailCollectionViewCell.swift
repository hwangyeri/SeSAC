//
//  iTunesDetailCollectionViewCell.swift
//  SeSACRxThreads
//
//  Created by Yeri Hwang on 2023/11/07.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class iTunesDetailCollectionViewCell: UICollectionViewCell {
    
    let screenshotImageView: UIImageView = {
        let imageView = ScreenshotImageView()
        return imageView
    }()
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        contentView.addSubview(screenshotImageView)
        
        screenshotImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
