//
//  iTunesSearchViewController.swift
//  SeSACRxThreads
//
//  Created by Yeri Hwang on 2023/11/06.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

class iTunesSearchViewController: UIViewController {
    
    private let titleLabel: UILabel = {
       let view = UILabel()
        view.text = "검색"
        view.textColor = .label
        view.font = .boldSystemFont(ofSize: 24)
        return view
    }()
    
    private let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.searchBarStyle = .minimal
        view.placeholder = "게임, 앱, 스토리 등"
        view.showsCancelButton = true
        return view
    }()
    
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(iTunesSearchTableViewCell.self, forCellReuseIdentifier: iTunesSearchTableViewCell.reuseIdentifier)
        view.backgroundColor = .white
        view.rowHeight = 300
        view.separatorStyle = .none
       return view
     }()
    
    var data: [AppInfo] = []
    lazy var dataSubject = BehaviorSubject(value: data)
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureLayout()
        bind()
    }
    
    func bind() {
        
        dataSubject
            .bind(to: tableView.rx.items(cellIdentifier: iTunesSearchTableViewCell.reuseIdentifier, cellType: iTunesSearchTableViewCell.self)) { (row, element, cell) in
                cell.appNameLabel.text = element.trackName
                cell.sellerNameLabel.text = element.sellerName
                cell.genreLabel.text = element.genres.first
                
                Observable.just(element.averageUserRating)
                    .map { String(format: "%.1f", $0) }
                    .bind(to: cell.appRateLabel.rx.text)
                    .disposed(by: cell.disposeBag)
                
                Observable.just(element.artworkUrl512)
                    .map { URL(string: $0) }
                    .subscribe(with: self) { owner, url in
                        if let url = url {
                            cell.appIconImageView.kf.setImage(with: url)
                        } else {
                            cell.appIconImageView.image = UIImage(systemName: "xmark.icloud")
                        }
                    }
                    .disposed(by: cell.disposeBag)
                
                let urls = element.screenshotUrls.prefix(3).compactMap { URL(string: $0) }
                
                for (index, url) in urls.enumerated() {
                    if index == 0 {
                        cell.screenshotImageView1.kf.setImage(with: url)
                    } else if index == 1 {
                        cell.screenshotImageView2.kf.setImage(with: url)
                    } else if index == 2 {
                        cell.screenshotImageView3.kf.setImage(with: url)
                    }
                }
        
                cell.downloadButton.rx.tap
                    .subscribe(with: self) { owner, value in
                        owner.navigationController?.pushViewController(iTunesDetailViewController(), animated: true)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .flatMapLatest { query -> Observable<SearchAppModel> in // flatMapLatest: 새로운 요소가 전달될 때마다 내부 Observable 시퀀스를 새로운 것으로 교체
                return iTunesAPIManager.fetchData(query: query)
            }
            .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: [])) // error 예외처리
            .drive(with: self) { owner, result in
                owner.dataSubject.onNext(result.results)
            }
            .disposed(by: disposeBag)
    }
    
    func configureLayout() {
        [titleLabel, searchBar, tableView].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
