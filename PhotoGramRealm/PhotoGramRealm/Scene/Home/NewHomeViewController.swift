//
//  NewHomeViewController.swift
//  PhotoGramRealm
//
//  Created by 황예리 on 2023/09/17.
//

import UIKit
import SnapKit
import RealmSwift

class NewHomeViewController: BaseViewController {
    
    let realm = try! Realm()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    var list: Results<DiaryTable>!
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, DiaryTable>!
    
    let repository = DiaryTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = realm.objects(DiaryTable.self)
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.diaryTitle
            // Error: Value of type 'Object' (aka 'RealmSwiftObject') has no member 'diaryTitle'
            content.secondaryText = itemIdentifier.contents
            content.attributedText = itemIdentifier.diaryDate
            content.image = loadImageFromDocument(fileName: "yeri_\(itemIdentifier._id).jpg")
            cell.contentConfiguration = content
            
        })
        
    }
    
    static func layout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    override func configure() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton, backupButton]
    }
    
    @objc func plusButtonClicked() {
        navigationController?.pushViewController(AddViewController(), animated: true)
    }
    
    @objc func backupButtonClicked() {
        navigationController?.pushViewController(BackupViewController(), animated: true)
    }
    
    @objc func sortButtonClicked() {
        
    }
    
    @objc func filterButtonClicked() {
        print(#function)
        
        list = repository.fetchFilter()
        collectionView.reloadData()
    }
    
}

extension NewHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = list[indexPath.row]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.data = list[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

