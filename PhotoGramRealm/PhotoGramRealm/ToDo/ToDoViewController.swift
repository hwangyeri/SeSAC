//
//  ToDoViewController.swift
//  PhotoGramRealm
//
//  Created by 황예리 on 2023/09/08.
//

import UIKit
import RealmSwift
import SnapKit

class ToDoViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm() // default.realm 안에 TodoTable
    
    let tableView = UITableView()
    
    //var list: Results<ToDoTable>!
    var list: Results<DetailTable>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let data = ToDoTable(title: "영화보기", favorite: false)
//
//        let memo = Memo()
//        memo.content = "주말에 팝콘 먹으면서 영화 보기"
//        memo.date = Date()
//
//        data.memo = memo // 트랜잭션 내에 들어가도 되고 밖에 있어도됨, null 값이여도 상관없다고 memo 정의
//
//        try! realm.write {
//            realm.add(data)
//        }
        
        
//        let data = ToDoTable(title: "장보기", favorite: true)
//
//        let detail1 = DetailTable(detail: "양파", deadline: Date()) // detailTable 구조 만듦
//        let detail2 = DetailTable(detail: "사과", deadline: Date())
//        let detail3 = DetailTable(detail: "고구마", deadline: Date())
//
//        data.detail.append(detail1)
//        data.detail.append(detail2)
//        data.detail.append(detail3)
//
//        try! realm.write {
//            realm.add(data)
//        }
        
        print(realm.configuration.fileURL) // 파일 위치 출력
        //createDetail()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        list = realm.objects(DetailTable.self)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell")!
        let data = list[indexPath.row]
//        cell.textLabel?.text = "\(data.title): \(data.detail.count)개 \(data.memo?.content ?? "")" // detailTable 에 해당 항목 없어서 오류
        
        cell.textLabel?.text = "\(data.detail) in \(data.mainToDo.first?.title ?? "")" // 폴더가 어디인지 명칭을 가져와서 사용가능
        //어떤 메인 투두 안에 있는지 알 수 있음
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 데이터 제거할때 순서 중요! // 장보기 먼저 지워버리면, 장보기의 세부할일 영영 남게됨 // detailTable 먼저 지우고 todoTable 지워야함
//        let data = list[indexPath.row]
//
//        try! realm.write {
//            realm.delete(data.detail) // detail 먼저 지우고 todo 지우기!
//            realm.delete(data) // 데이터 제거
//        }
//
//        tableView.reloadData() // 데이터 지운거 반영 -> 테이블뷰 갱신   // 다른 테이블에 해당하는 값이라 주석처리
        
    }
    
    func createDetail() {
        print(realm.objects(ToDoTable.self))
        //createToDo()
        
        let main = realm.objects(ToDoTable.self).where { // default.realm -> ToDoTable 까지 들어옴 // ToDoTable Recode 접근 가능
            $0.title == "장보기" // 그 중에서 ~ 찾아라
        }.first!
        
        for i in 55...65 { // Recode에 내용 추가
            
            let detailToDo = DetailTable(detail: "장보기 세부 할일 \(i)", deadline: Date())
            
            try! realm.write {
                //realm.add(detailToDo)
                main.detail.append(detailToDo)
            }
        }
        
    }
    
    func createToDo() {
        
        for i in ["장보기", "영화보기", "리캡하기", "좋아요구현하기", "잠자기"] {
            
            let data = ToDoTable(title: i, favorite: false)
            
            try! realm.write { // 특정 레코드 add 요청
                realm.add(data)
            }
        }
    }
    

}
