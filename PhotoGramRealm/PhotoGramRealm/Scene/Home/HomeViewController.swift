//
//  HomeViewController.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import SnapKit
import RealmSwift

class HomeViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 100
        view.delegate = self
        view.dataSource = self
        view.register(PhotoListTableViewCell.self, forCellReuseIdentifier: PhotoListTableViewCell.reuseIdentifier)
        view.backgroundColor = .black
        return view
    }()
    
    var tasks: Results<DiaryTable>!

    let repository = DiaryTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Realm Read // 데이터 가져오기
        //print(realm.configuration.fileURL ?? "fileURL print Error")
        
        tasks = repository.fetch()
        
        repository.checkSchemaVersion()
        
        print(tasks)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData() // 갱신
        // 뷰에 대한 갱신만 해도 변경되는 데이터 반영됨
        // 데이터가 어디서 오는지 연결만 해주면 Results 가 실시간으로 데이터 관리를 해줌
    }
    
    override func configure() {
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton, backupButton]
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
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
        
        tasks = repository.fetchFilter()
        tableView.reloadData() // 데이터가 변경되었으니 테이블뷰 갱신 필요
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListTableViewCell.reuseIdentifier) as? PhotoListTableViewCell else { return UITableViewCell() }
        
        let data = tasks[indexPath.row]
        
        cell.titleLabel.text = data.diaryTitle
        cell.contentLabel.text = data.contents
        cell.dateLabel.text = "\(data.diaryDate)"
        cell.diaryImageView.image = loadImageFromDocument(fileName: "yeri_\(data._id).jpg") // 도큐먼트 문서에 저장된 이미지만 가져옴
        
//        let value = URL(string: data.diaryPhoto ?? "") // 데이터 형변환, 밖으로 꺼냄으로 DB랑 끊어지게 됨 // value 옵셔널 상태
//
//        //String -> Url -> Data -> UIImage
//        //1. 셀 서버통신 용량이 크다면 로드가 오래 걸릴 수 있음.
//        // cellForRowAt 셀마다 실행됨, 생각보다 빌드할때 이미지 뷰 로딩이 길어질 수 있음 // 작은 데이터는 처리해도 되지만 큰 이미지면 문제가 될 수 있음
//        //2. 이미지를 미리 UIImage 형식으로 반환하고, 셀에서 UIImage를 바로 보여주자!
//        // => 재사용 매커니즘을 효율적으로 사용하지 못할 수도 있고, UIImage 배열 구성 자체가 오래 걸릴 수 있음
//        DispatchQueue.global().async { // 이미지 다운로드 과정
//            if let url = value, let data = try? Data(contentsOf: url ) { // let url = value 옵셔널 바인딩 처리
//                // if let data.diaryPhoto ?? "" -> Error : 데이터베이스로 온 값을 글로벌로 접근함, 밖으로 꺼내줘야함
//
//                DispatchQueue.main.async { // UI 업데이트 과정
//                    cell.diaryImageView.image = UIImage(data: data)
//                }
//            }
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        vc.data = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
        //Realm Delete
//        let data = tasks[indexPath.row]
//
//        removeImageFromDocument(fileName: "yeri_\(data._id).jpg")
//        // Error : 코드 위치문제 // 지울 때 상수에 있는 PK 까지 날림, id가 없어서 찾아서 삭제를 못함 => 따라서 데이터가 살아있을때 제거해줘야됨
//
//        try! realm.write {
//            realm.delete(data) // DiaryTable에서는 잘 지워지지만, 도큐먼트 폴더(램)에 저장된 이미지는 지워지지않음 // 영영 쌓이게 되는 용량, 제거 필요
//        }
//
//        // 원래 있던 위치
//
//        tableView.reloadData() // 클릭하면 바로 데이터가 삭제되어서 주석처리
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let like = UIContextualAction(style: .normal, title: "좋아요") { action, view, completionHandler in
            print("좋아요 선택됨")
        } //  기능까지 가지고 있는 버튼 하나
        
        let sample = UIContextualAction(style: .normal, title: "sample") { action, view, completionHandler in
            print("sample 선택됨")
        }
        
        return UISwipeActionsConfiguration(actions: [like, sample]) // 왼쪽부터 Index[0]
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let like = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in // title 은 옵셔널이라서 비울 수 있음
            print("좋아요 선택됨")
        }
        
        like.backgroundColor = .orange
        like.image = tasks[indexPath.row].diaryLike ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        
        let test = UIContextualAction(style: .normal, title: "테스트") { action, view, completionHandler in
            print("테스트 선택됨")
        }
        
        test.backgroundColor = .systemIndigo
        test.image = UIImage(systemName: "pencil")
        
        return UISwipeActionsConfiguration(actions: [like, test]) // 오른쪽부터 Index[0]
    }
    
}
