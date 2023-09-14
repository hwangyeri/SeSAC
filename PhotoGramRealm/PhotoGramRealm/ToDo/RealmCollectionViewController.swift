//
//  RealmCollectionViewController.swift
//  PhotoGramRealm
//
//  Created by 황예리 on 2023/09/14.
//

import UIKit
import SnapKit
import RealmSwift

class RealmCollectionViewController: BaseViewController {
    
    let realm = try! Realm()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    var list: Results<ToDoTable>! // viewDidLoad 시점에서 데이터 가져오기
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, ToDoTable>! // collectionView.register 대신 사용
    // CellRegistration 의 String(ToDoTable) 에 들어갈 형식은 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = realm.objects(ToDoTable.self)
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //itemIdentifier = list[indexPath.item]
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.image = itemIdentifier.favorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            content.text = itemIdentifier.title
            content.secondaryText = "\(itemIdentifier.detail.count)개의 세부 할일"
            cell.contentConfiguration = content
            
        })
        
    }
    
    static func layout() -> UICollectionViewLayout {
        
        let configuration = UICollectionLayoutListConfiguration(appearance: .grouped) // 구조체로 초기화, 컬렉션 뷰 스타일 지정
        let layout = UICollectionViewCompositionalLayout.list(using: configuration) // 스타일 컬렉션 뷰에 등록
        return layout
    }
    
}

extension RealmCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = list[indexPath.item] // 이때 data 의 타입이 두번째 CellRegistration 에 들어감
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: data) // 셀 등록해주는 코드 대신 어떤 셀에 어떤 데이터가 들어갈지 지정 //
        return cell
    }
    
}
