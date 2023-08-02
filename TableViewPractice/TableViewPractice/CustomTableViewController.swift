//
//  CustomTableViewController.swift
//  TableViewPractice
//
//  Created by 황예리 on 2023/07/28.
//

import UIKit

/*
 230802
 1. 파티를 막자
 2. sender.tag
 3. 데이터 Model
 */

class CustomTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    var todo = ToDoInformation() {
        didSet { // 변수가 달라짐을 감지!
            print("didSet")
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80
        
        searchBar.placeholder = "할일을 입력해보세요"
        searchBar.searchTextField.addTarget(self, action: #selector(searchBarReturnTapped), for: .editingDidEndOnExit)
    }
    
    @objc func searchBarReturnTapped() {
        //ToDo 항목을 // 식판
        let data = ToDo(main: searchBar.text!, sub: "23.08.01", like: false, done: false, color: ToDoInformation.randomBackgroundColor())
        //list에 추가
        todo.list.insert(data, at: 0)
        //UX
        searchBar.text = ""
        //갱신
        //tableView.reloadData()
    }

    //1.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.list.count
    }
    
    //2.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as! CustomTableViewCell
        let row = todo.list[indexPath.row]
        
        cell.configureCell(row: row)
        
        cell.starButton.tag = indexPath.row
        cell.starButton.addTarget(self, action: #selector(starButtonClicked), for: .touchUpInside) // 코드로 액션 연결
        
        return cell
    }
    
    @objc
    func starButtonClicked(_ sender: UIButton) {
        print(#function, "\(sender.tag)")
        
        //todo.list[IndexPath.row].like
        todo.list[sender.tag].like.toggle()
        
        //tableView.reloadData()
    }
    
    //3. 셀 선택
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        
        vc.data = todo.list[indexPath.row]
        
        present(vc, animated: true)
        
        //tableView.reloadData() // modal 올라간 후에도 클린된 상태 처리하기
        tableView.reloadRows(at: [indexPath], with: .none) // 전체 데이터가 아닌 선택된 셀만 reloadData
    }
    
    //삭제
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //제거 -> 갱신
        todo.list.remove(at: indexPath.row)
        
        //tableView.reloadData()
    }
    
    

}
