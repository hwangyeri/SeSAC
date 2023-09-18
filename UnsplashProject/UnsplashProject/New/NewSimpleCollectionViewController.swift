//
//  SimpleCollectionViewController.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/14.
//

import UIKit
import SnapKit

// 0914 FlowLayout 을 쓰지않는 형태로 구현
// 0915 UICollectionViewDataSource프로토콜 대신 -> Diffable Data Source 사용

class NewSimpleCollectionViewController: UIViewController {
    
    // 리터럴 한 값 열거형으로 구성
    enum Section: Int, CaseIterable {
        case first = 2000
        case second = 1
    }
    
    var viewModel = NewSimpleViewModel()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
//    //collectionView.reguster // 1. CellRegistration 선언
//    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>! // iOS 14 이상 사용 가능한 CustomCell
    
    // extension UICollectionViewDataSource 대신 해주는 친구
    var dataSource: UICollectionViewDiffableDataSource<Section, User>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configurationDataSource()
        
        updateSnapshot()
        
        //데이터가 바뀔때마다 updateSnapshot 을 해달라, collectionView.reloadData 랑 똑같음
        viewModel.list.bind { user in // bind 메서드를 쓰면 달라지는 매개변수를 계속 호출하기때문에 언제 어떤 타이밍에 데이터가 변경되더라도 잘 업데이트 됨
            self.updateSnapshot()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.append()
        }
    }
    
    func updateSnapshot() {
        
        // numberOfItemsInSection 대신 사용하는 친구
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>() // 뷰에 보여지게 할 고유한 값들 저장
        
        // IndexPath 의 개념은 더이상 사용되지 않는다
        //snapshot.appendSections([Section.first.rawValue, Section.second.rawValue]) // 섹션을 하나 쓸게, 개별적인 섹션
        //snapshot.appendSections(Section.allCases) // [first, second]
        //snapshot.appendItems(list, toSection: Section.first) // 개별적인 아이템
        //snapshot.appendItems(list2, toSection: Section.second)
        
        //var snapshot = NSDiffableDataSourceSnapshot<String, User>()
        //snapshot.appendSections(["고래밥", "Yeri"])
        //snapshot.appendItems(list, toSection: "고래밥")
        //snapshot.appendItems(list2, toSection: "Yerl")
        
        snapshot.appendSections(Section.allCases) // [first, second]
        snapshot.appendItems(viewModel.list.value, toSection: .first)
        snapshot.appendItems(viewModel.list2, toSection: .second)
        
        dataSource.apply(snapshot) // apply 가 reloadData 라고 보면 됨
    }
    
    static private func createLayout() -> UICollectionViewLayout { // 컬렉션 뷰를 만들때 넣어줘야함, static 붙여서 빠르게 생성 후 초기화할때 넣어줘야함
        //14+ 컬렉션뷰를 테이블뷰 스타일처럼 사용가능 (ListContentConfiguration)
        // private 외부에 노출되지 않아서 은닉화 가능
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemGreen
        
        // 3. CellRegistration 호출
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configurationDataSource() { // 데이터 소스, 셀에 대한 처리를 외부에서 볼 필요가 없어서 private 처리
        
        // 2. CellRegistration 등록
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, User>(handler: { cell, indexPath, itemIdentifier in
            //UICollectionView.CellRegistration : iOS 14, 메서드 대신 제네릭을 사용, 새 셀이 생성될 때마다 클로저가 호출 // 셀을 등록할 수 있는 또다른 방법
            //14+ Registeration API 로 셀 재사용을 보다 쉽게 구현, 기존의 Cell Identifier XIB 등록하는 메서드 대신 제너릭 형태 사용
            // cellForItemAt 에서 했던 각 셀마다 디자인이나 데이터 처리가 이루어짐
            // ListCell
            
            //셀 디자인 및 데이터 처리
            var content = UIListContentConfiguration.valueCell() // 시스템 셀 종류
            content.text = itemIdentifier.name
            content.textProperties.color = .brown
            content.secondaryText = "\(itemIdentifier.age)"
            content.image = UIImage(systemName: "star.fill")
            content.imageProperties.tintColor = .systemRed
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 20
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2
            backgroundConfig.strokeColor = .systemPink
            cell.backgroundConfiguration = backgroundConfig
            
        })
        
        //CellForItemAt // cellForItemAt - dequeueConfiguredReusableCell 대신 사용하는 친구
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in // dataSource 초기화
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            // 어떤 셀을 어떻게 재사용 할건지
            return cell
        })
        
    }
    
}

extension NewSimpleCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //let user = viewModel.list.value[indexPath.item] // 이전 사용했던 방식
        
        guard let user = dataSource.itemIdentifier(for: indexPath) else { // 런타임 오류가 발생하지 않도록 대처
            print("문제가 있을 때 토스트 얼럿이나 예외처리")
            return
        }
        
        dump(user)
//        viewModel.removeUser(idx: indexPath.item)
    }

}

extension NewSimpleCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.insertUser(name: searchBar.text!)
    }
}

//extension SimpleCollectionViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
//        // 인덱스 -> 모델 기반 // <Cell, Item> 제네릭 타입
//        // 해당하는 메서드가 실행되면서 cellRegistration 클로저 구문이 실행됨
//        // cellForItemAt 가 했던 일 : 셀에 대한 등록 -> 데이터 표현 -> 데이터 처리
//        return cell
//    }
//
//}
