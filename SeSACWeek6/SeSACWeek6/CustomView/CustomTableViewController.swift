//
//  CustomTableViewController.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/24.
//

import UIKit
import SnapKit

struct Sample {
    let text: String
    var isExpand: Bool
}

class CustomTableViewController: UIViewController {
    
    let tableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension //1.
        return view
    }()
    
    //var isExpand = false //false 2, true 0
    var list = [Sample(text: "테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트", isExpand: false), Sample(text: "sdjandjsaldnkldmal", isExpand: false), Sample(text: "테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트 테스트 셀 텍스트", isExpand: false)]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // 네가지 면에 0,0,0,0
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        //uinib - xib
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customCell")
    }
    

}

extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell")!
        let row = list[indexPath.row]
        cell.textLabel?.text = row.text
        cell.textLabel?.numberOfLines = row.isExpand ? 0 : 2 //2.
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        isExpand.toggle()
        list[indexPath.row].isExpand.toggle()
//        tableView.reloadData()
        tableView.reloadRows(at: [indexPath], with: .automatic) // IndexPath(row: 3, section: 0) 특정 셀만 갱신하는 것도 가능
    }
    
    
}
