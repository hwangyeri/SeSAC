//
//  SearchViewController.swift
//  SeSACRxThreads
//
//  Created by Yeri Hwang on 2023/11/05.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
     
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 180
        view.separatorStyle = .none
       return view
     }()
    
    private let searchBar = UISearchBar()
     
    var data = ["A", "B", "C", "AB", "D", "ABC", "aaa", "bbb", "ccc"]
    
    lazy var items = BehaviorSubject(value: data)
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        bind()
    }
     
    func bind() {
        
        // MARK: - cellForRowAt
        items
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.appNameLabel.text = element
                cell.appIconImageView.backgroundColor = .green
                // cell 안에 버튼 눌렀을때 처리
                cell.downloadButton.rx.tap
                    .subscribe(with: self) { owner, value in
                        print("downloadButton Tap")
                        owner.navigationController?.pushViewController(SampleViewController(), animated: true)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        // MARK: - didSelectRowAt
        tableView.rx.itemSelected
            .subscribe(with: self) { owner, indexPath in
                print("itemSelected:", indexPath)
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(String.self)
            .subscribe(with: self) { owner, indexPath in
                print("modelSelected", indexPath)
            }
            .disposed(by: disposeBag)
        
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(String.self))
            .map { "셀 선택: \($0), \($1)"}
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        // MARK: - SearchBar
        searchBar
            .rx.searchButtonClicked // Observable
            .withLatestFrom(searchBar.rx.text.orEmpty) { void, text in // Observable
                // 버튼 클릭 했을때, 클릭된 값을 가지고 넘어가는 경우에 많이 쓰임
                return text
            }
            .subscribe(with: self) { owner, text in
                owner.data.insert(text, at: 0) // 윗줄에서 반환 받은 text
                owner.items.onNext(owner.data)
            }
            .disposed(by: disposeBag)
        
        // 검색어 기반으로 특정 쿼리에 해당하는 값 찾기
        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance) // 잠깐 멈췄을때 실시간 검색해주기 (콜수 줄이는 방법)
            .distinctUntilChanged() // 같은 값이 연달아서 제공되면 같은 값만 무시하는 기능 (이전에 검색한 값과 같으면 네트워크 통신을 안보냄, 이전 데이터 계속 활용)
            .subscribe(with: self) { owner, value in
                // 검색 결과
                let result = value == "" ? owner.data : owner.data.filter { $0.contains(value) }
                owner.items.onNext(result)
                print("실시간 검색: \(value)")
            }
            .disposed(by: disposeBag)
        
    }
    
    private func configure() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

    }
}

