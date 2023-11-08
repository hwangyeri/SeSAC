//
//  iTunesDetailViewController.swift
//  SeSACRxThreads
//
//  Created by Yeri Hwang on 2023/11/06.
//

import UIKit
import SnapKit

class iTunesDetailViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.text = "kakao aka"
        return label
    }()
    
    private let sellerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .lightGray
        label.text = "kakao aka"
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 16
        return button
    }()
    
    private let newLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "새로운 소식"
        label.textColor = .label
        return label
    }()

    private let versionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        label.text = "버전 2.31.5"
        return label
    }()
    
    private let releaseNotesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.text = "ㅅㄷㅅ댖슺아루ㅡ나ㅣ릐ㅏㄴ므라ㅣ무러ㅏㅜㄹ저ㅏ두러자ㅜ랃르자ㅣㄷ르잗무 라ㅓㅈ두랒ㄷ루ㅡ다ㅣㅈ르ㅏㅣㅡㄹㅇ님르 ㅣㅏㅈ르 ㅏㅈ드라ㅣ즏리ㅏㄷ즈라즈라 ㅡㅌ ㅍ칮ㅁㄹ"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var detailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureDetailCollectionLayout())
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.text = "ㅅㄷㅅ댖슺아루ㅡ나ㅣ릐ㅏㄴ므라ㅣ무러ㅏㅜㄹ저ㅏ두러자ㅜ랃르자ㅣㄷ르잗무 라ㅓㅈ두랒ㄷ루ㅡ다ㅣㅈ르ㅏㅣㅡㄹㅇ님르 ㅣㅏㅈ르 ㅏㅈ드라ㅣ즏리ㅏㄷ즈라즈라 ㅡㅌ ㅍ칮ㅁㄹ"
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureLayout()
        bind()
    }
    
    func bind() {

    }
    
    func configureLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [appIconImageView, appNameLabel, sellerNameLabel, downloadButton, newLabel, versionLabel, releaseNotesLabel, detailCollectionView, descriptionLabel].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        appIconImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15)
            make.size.equalTo(100)
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView).inset(10)
            make.leading.equalTo(appIconImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview()
        }
        
        sellerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom).offset(12)
            make.leading.equalTo(appNameLabel)
            make.trailing.equalToSuperview()
        }
        
        downloadButton.snp.makeConstraints { make in
            make.top.equalTo(sellerNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(appNameLabel)
            make.height.equalTo(32)
            make.width.equalTo(72)
        }
        
        newLabel.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView.snp.bottom).offset(20)
            make.leading.equalTo(appIconImageView)
        }
        
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(newLabel.snp.bottom).offset(8)
            make.leading.equalTo(newLabel)
        }
        
        releaseNotesLabel.snp.makeConstraints { make in
            make.top.equalTo(versionLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        detailCollectionView.snp.makeConstraints { make in
            make.top.equalTo(releaseNotesLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
            make.height.equalTo(500)
        }
        detailCollectionView.backgroundColor = .lightGray
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(detailCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureDetailCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 10
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }

}
