//
//  HomeView.swift
//  PhotoGram
//
//  Created by 황예리 on 2023/08/31.
//

import UIKit
import SnapKit

class HomeView: BaseView {
    
    var searchBar = {
        let view = UISearchBar()
        view.placeholder = "원하는 이미지를 검색해보세요!"
        return view
    }()
    
    // protocol 2.
    // 강한 순환 참조가 되어있어서 weak가 없으면 deinit이 안됨
    weak var delegate: HomeViewProtocol?
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
//        view.delegate = self
//        view.dataSource = self
        return view
    }()
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8) // 컬렉션뷰 섹션, 왼쪽 오른쪽 여백
        let size = UIScreen.main.bounds.width - 32 // 여백 8 * 4 = 32
        layout.itemSize = CGSize(width: size / 3, height: size / 3)
        return layout
    }
    
    override func configureView() {
        addSubview(collectionView)
        addSubview(searchBar)
    }
    
    override func setConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
}
