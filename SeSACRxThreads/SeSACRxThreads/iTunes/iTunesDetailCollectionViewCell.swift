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
    
    let screenshotImageView4: UIImageView = {
        let imageView = ScreenshotImageView()
        return imageView
    }()
    
    let screenshotImageView5: UIImageView = {
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
        [screenshotImageView1, screenshotImageView2, screenshotImageView3, screenshotImageView4, screenshotImageView5].forEach {
            contentView.addSubview($0)
        }
        
    }
    
}
