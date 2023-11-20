//
//  iTunesDetailViewController.swift
//  SeSACRxThreads
//
//  Created by Yeri Hwang on 2023/11/06.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

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
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let sellerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .lightGray
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
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "새로운 소식"
        label.textColor = .label
        return label
    }()

    private let versionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private let releaseNotesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
        
    var selectedCellData: BehaviorRelay<AppInfo> = BehaviorRelay(value: AppInfo(screenshotUrls: [], trackName: "", genres: [], trackContentRating: "", description: "", price: 0.0, sellerName: "", formattedPrice: "", userRatingCount: 0, averageUserRating: 0.0, artworkUrl512: "", languageCodesISO2A: [], trackId: 0, version: "", releaseNotes: ""))
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureLayout()
        bind()
//        print("DetailView", selectedCellData)
    }
    
    func bind() {

        selectedCellData
            .asDriver()
            .drive(with: self) { owner, data in
                owner.appNameLabel.text = data.trackName
                owner.sellerNameLabel.text = data.sellerName
                owner.descriptionLabel.text = data.description
                owner.versionLabel.text = "버전 " + data.version
                owner.releaseNotesLabel.text = data.releaseNotes
                
                if let url = URL(string: data.artworkUrl512) {
                    owner.appIconImageView.kf.setImage(with: url)
                } else {
                    owner.appIconImageView.image = UIImage(systemName: "xmark.icloud")
                }
            }
            .disposed(by: disposeBag)
        
        // MARK: 블로그 글 작성하기 :: selectedCellData 인데 두개로 분리해서 쓰는게 괜찮을까? Unicast, Drive Stream 공유 기능 내장
        
        selectedCellData
            .asDriver()
            .map { $0.screenshotUrls }
            .drive(collectionView.rx.items(cellIdentifier: iTunesDetailCollectionViewCell.reuseIdentifier, cellType: iTunesDetailCollectionViewCell.self)) { (row, element, cell) in
                if let url = URL(string: element) {
                    cell.screenshotImageView.kf.setImage(with: url)
                    print(url)
                } else {
                    cell.screenshotImageView.image = UIImage(systemName: "xmark.icloud")
                }
            }
            .disposed(by: disposeBag)

        downloadButton.rx.tap
            .subscribe(with: self) { owner, value in
                print("downloadButton Tap")
            }
            .disposed(by: disposeBag)
    }
    
    func configureLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [appIconImageView, appNameLabel, sellerNameLabel, downloadButton, newLabel, versionLabel, releaseNotesLabel, collectionView, descriptionLabel].forEach {
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
            make.trailing.equalToSuperview().inset(5)
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
            make.bottom.equalTo(appIconImageView)
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
        
        collectionView.register(iTunesDetailCollectionViewCell.self, forCellWithReuseIdentifier: iTunesDetailCollectionViewCell.reuseIdentifier)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(releaseNotesLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
            make.height.equalTo(500)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
        }
    }
    
    static func collectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 500)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        return layout
    }

}
