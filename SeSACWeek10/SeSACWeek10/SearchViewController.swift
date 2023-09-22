//
//  SearchViewController.swift
//  SeSACWeek10
//
//  Created by 황예리 on 2023/09/21.
//

import UIKit
import SnapKit

// 시스템 셀이 아닌 커스텀 셀 사용
// (lazy var collectionView) or (static func configureCollectionLayout)

// 230921 UICollectionViewDataSource -> UICollectionViewDiffableDataSource
// 230922 UICollectionViewFlowLayout -> UICollectionViewCompositionalLayout

// 간단한 레이아웃 => UICollectionViewFlowLayout
// 복합적인 UI (ex. 앱스토어, 핀터레스트) => UICollectionViewCompositionalLayout

class SearchViewController: UIViewController {

    let list = Array(0...100)

    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
    // 처음에는 크기에 대한 설정이 없지면 나중에 Layout 으로 지정해줌
    // lazy var 를 통해서 configureCollectionLayout 가 먼저 생성된 후 collectionView 가 생성될 수 있도록 함
    // 인스턴스 메서드, 프로퍼티는 같은 시점에서 생성되기 때문에 collectionView 가 필요한 시점에 생성될 수 있도록 lazy 를 통해서 초기화 시점을 미룬 것
    
    // dataSource 선언
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! // 데이터 소스에 대한 프로퍼티

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureDataSource()
        //collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "cell") // 셀 등록
    }
    
    // CompositionalLayout
    static func configureCollectionLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(1.0))
        // 그룹의 사이즈를 기준으로 아이템 사이즈를 계산함
        // 상대적으로 계산이 되는 값은 그룹 절대적인 높이가 80이라서 아이템 사이즈가 0.5 면 40
        // IF, 4 * n 이면 widthDimension: .fractionalWidth(1/4)
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // 아이템 사이즈는 이 규칙에 따라서 셀을 만들거야~, 패키징 된 상태
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        // 너비는 상대적인 비율, 높이는 절대적인 값으로 설정된 상태
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        // 그룹.horizontal 로 넣어줘서 수평으로 아이템이 들어간 상태
        // 그룹 컨테이너는 layoutSize 로 만들건데, 그 안에 repeatingSubitem이 들어갈거고, count개가 들어갈거야 ~
        // IF, 3 * n => 0,1,2번 Group 0번 Item
        
        //let group = NSCollectionLayoutGroup.horizontal(layoutSize: <#T##NSCollectionLayoutSize#>, subitem: <#T##NSCollectionLayoutItem#>, count: <#T##Int#>)
        // 16 까지만 사용 가능, 현재는 연산하는 과정이 바뀜
        
        group.interItemSpacing = .fixed(10) // 그룹 내의 간격
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10) // 컬렉션 뷰의 여백
        section.interGroupSpacing = 10 // 그룹과 그룹 사이 간격
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    // FlowLayout
    //    static func configureCollectionLayout() -> UICollectionViewLayout { // static 을 쓰면 데이터에 따로 저장됨
    //        // static 는 인스턴스가 생성되기 전에 메모리 상에서 이미 존재
    //        // static 은 한번 호출되면 영영 메모리에서 사라지지않음, 소거할 수 없음
    //        // 첫화면이면 static 쓸만함, 위치나 상황에 따라서 잘 판단해서 사용하기!
    //        let layout = UICollectionViewFlowLayout()
    //        layout.itemSize = CGSize(width: 50, height: 50)
    //        layout.scrollDirection = .vertical
    //        return layout
    //    }

    func configureHierarchy() {
        view.addSubview(collectionView)
    }

    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureDataSource() {
       
        // ListCell 이 아닌 CustomCell(SearchCollectionViewCell)
        // 셀 설정에 대한 결과를 여기서 받고있음, cellForItemAt 의 연장선으로 보면 됨
        let cellRegistration = UICollectionView.CellRegistration<SearchCollectionViewCell, Int> { cell, indexPath, itemIdentifier in
            cell.imageView.image = UIImage(systemName: "star")
            cell.label.text = "\(itemIdentifier)번"
        }
        
        // dataSource 초기화
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier) // 셀 설정
        })
        
        // 갱신 대신 apply
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>() // dataSource 의 타입이랑 일치하면 됨
        snapshot.appendSections([0]) // 섹션에 어떤 데이터가 들어갈지, 인덱스패스가 아닌 어떤 데이터로 관리할지 넣어줘야함, Int 는 보통 0 넣어줌
        snapshot.appendItems(list)
        dataSource.apply(snapshot)
    }

//    // Diffable 로 리팩토링
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1 // defaults 가 1이라서 1일때는 굳이 쓸 필요없음
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCollectionViewCell // 셀 설정
//        cell.label.text = "\(list[indexPath.item])번"
//        return cell
//    }

}

// 재사용이 필요없으면 scrollView 사용, 재사용이 필요하면 collectionView

//class SearchViewController: UIViewController { // 세로 스크롤 구현
//
//    let scrollView = UIScrollView()
//    let contentView = UIView()
//
//    let imageView = UIImageView()
//    let label = UILabel()
//    let button = UIButton()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureHierarchy()
//        configureLayout()
//        configureContetnView()
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) { // offset 기반으로 alpha 처리
//        print(scrollView.contentOffset)
//        print(scrollView.contentOffset.y)
//
//        if scrollView.contentOffset.y >= 50 {
//            label.alpha = 100 - 3
//        }
//    }
//
//    func configureContetnView() {
//        contentView.addSubview(imageView)
//        contentView.addSubview(button)
//        contentView.addSubview(label)
//
//        imageView.backgroundColor = .orange
//        button.backgroundColor = .magenta
//        label.backgroundColor = .systemGreen
//
//        imageView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(200)
//        }
//
//        button.snp.makeConstraints { make in
//            make.bottom.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(80)
//        }
//
//        label.text = "dm\nkdms\nkdkmd\nk\nmd\nkmd\nkmdm\ndkdm\nkd\nmkd\ndkdsm\nmkdm\ndlksmd\nksmlkdm\ndmksmkd\nks\nmkdmd\nkmskdmksmkldmksm\ndmklddmklmd"
//        label.textColor = .white
//        label.numberOfLines = 0
//        label.snp.makeConstraints { make in
//            make.horizontalEdges.equalTo(contentView)
//            make.top.equalTo(imageView.snp.bottom).offset(50)
//            make.bottom.equalTo(button.snp.top).offset(-50)
//        }
//    }
//
//    func configureHierarchy() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//    }
//
//    func configureLayout() {
//        //scrollView.bounces = false // 스크롤 시, 땡겨지는 바운스 효과 설정 가능
//        scrollView.backgroundColor = .lightGray
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//        contentView.backgroundColor = .white
//        contentView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView) // 프레임 영역이랑 똑같으면 스크롤 영역이 없는 것으로 인지
//            // 올바른 가이드x: 컨텐츠 영역이 가진 너비 중 가장 큰걸로 맞춰서 스크롤 되게 만들어서 이상해짐
//            make.width.equalTo(scrollView.snp.width) // 스크롤뷰 내에서 컨텐츠 레이아웃 잡기
//            // 가로 스크롤은 너비 잡기! 세로 스크롤은 높이 잡기!
//        }
//    }
//
//}

//class SearchViewController: UIViewController { // 가로 스크롤 구현
//
//    let scrollView = UIScrollView() // 인스턴스만 따로 만들어서 생성
//    let stackView = UIStackView() // 가로 스크롤
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        configureHierarchy()
//        configureLayout()
//        configureStackView()
//    }
//
//    func configureHierarchy() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(stackView)
//    }
//
//    func configureLayout() {
//        scrollView.backgroundColor = .lightGray
//        scrollView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(70)
//        }
//
//        stackView.spacing = 16
//        stackView.backgroundColor = .black
//        stackView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView)
//            make.height.equalTo(scrollView) // 가로 스크롤은 scrollView 높이만큼 지정해줘야함
//        }
//    }
//
//    func configureStackView() { // stackView 안에 레이블 추가
//        let label1 = UILabel()
//        label1.text = "안녕하세요"
//        label1.backgroundColor = .orange
//        label1.textColor = .white
//        stackView.addArrangedSubview(label1)
//
//        let label2 = UILabel()
//        label2.text = "반갑습니다"
//        label2.backgroundColor = .blue
//        label2.textColor = .white
//        stackView.addArrangedSubview(label2)
//
//        let label3 = UILabel()
//        label3.text = "안녕"
//        label3.backgroundColor = .red
//        label3.textColor = .white
//        stackView.addArrangedSubview(label3)
//
//        let label4 = UILabel()
//        label4.text = "헬로"
//        label4.textColor = .white
//        stackView.addArrangedSubview(label4)
//
//        let label5 = UILabel()
//        label5.text = "하이111111111111111111111"
//        label5.textColor = .white
//        stackView.addArrangedSubview(label5)
//    }
//
//
//}
