//
//  HomeView.swift
//  PhotoGram
//
//  Created by 황예리 on 2023/08/31.
//

import UIKit
import SnapKit

class HomeView: BaseView {
    
    // protocol 2.
    // 강한 순환 참조가 되어있어서 weak가 없으면 deinit이 안됨
    weak var delegate: HomeViewProtocol?
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        view.delegate = self
        view.dataSource = self
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
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        // 화면전환, 얼럿 못띄움 // navigation-push/pop, present-dismiss -> ViewController 에서만 할 수 있음
        // ViewController가 해당 기능을 할 수 있도록 처리, 신호를 받아 실행할 수 있게끔 Delegate Patten을 이용해서 명령함
        delegate?.didSelectItemAt(indexPath: indexPath)
    }
    
}
