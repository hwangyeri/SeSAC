//
//  ToDoTableViewController.swift
//  TableViewPractice
//
//  Created by 황예리 on 2023/07/27.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    var list = ["양식 제출", "미용실 가기", "장바구니 쇼핑", "과제하기", "영양제 사기", "올영 가기"]
    
    @IBOutlet var addTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        showAlert()
    }
    
    @IBAction func clickedAddButton(_ sender: UIBarButtonItem) {
        //1. list 에 내용 추가
        list.append("운동 하기")
        print(list)
        
        //2. tableView 갱신
        tableView.reloadData() // 다시 함수 실행, 리프레쉬
    }
    
    /*
     1. 셀 갯수 numberOfRowsInSection
     2. 셀 디자인 및 데이터 처리 cellForRowAt
     3. 셀 높이 heightForRowAt
     */
    
    //1. 섹션 내 셀의 갯수 : 카톡 친구 수만큼 셀 갯수가 필요해 라고 iOS에게 전달
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    //2. 셀 디자인 및 데이터 처리 : 카톡 프로필 모서리 둥글게, 프로필 이미지와 상태 메세지 반영 등
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function, indexPath)
        
        //Identifier 는 인터페이스 필더에서 설정!
        //dequeueReusableCell - settingCell을 재활용해서 데이터만 바꿔서 재사용 (재사용 매커니즘)
        // 뒤에 있는 데이터들은 화면에 보일때 사용
        // 셀 준비 - 그릇 만들고 조건에 맞는 데이터 보여주기, 그릇을 재활용
        // 그릇을 재활용하다보니 데이터가 남아있는 경우가 있음
        // 따라서, 떨이처리 필수
        // 조건문 -> let list -> numberOfRowsInSection : return list.count -> list[indexPath.row] -> 한줄
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        cell.textLabel?.text = list[indexPath.row]
        cell.backgroundColor = indexPath.row % 2 == 0 ? .lightGray : .white
        cell.textLabel?.textColor = .red
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        
        cell.detailTextLabel?.text = "detail"
        cell.detailTextLabel?.font = .systemFont(ofSize: 15)
        cell.detailTextLabel?.textColor = .blue
        
        cell.textLabel?.configureTitleText() //Extension
        
        cell.imageView?.image = UIImage(systemName: "star.fill")
        
        return cell
    }
    
    //3. 셀 높이 : Drfault 44, 서비스 구현에 따라 필요한 경우가 많지만, 항상 같은 높이를 셀에서 사용한다면 비효율적일 수 있음!
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
