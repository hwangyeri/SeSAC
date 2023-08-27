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
    
    //호출 연산자를 붙여서 viewDidLoad 보다 클로저 구민이 먼저 실행됨
    //CustomTableViewController 인스턴스 생성 직전에 클러저 구문이 우선 실행
    lazy var tableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension //1.
        view.delegate = self //자기 자신의 인스턴스
        view.dataSource = self
        //uinib - xib
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell") // xib 안쓰고 클래스 그 자체를 테이블뷰에 등록
        return view
    }()
    
    let imageView = {
        let view = PosterImageView(frame: .zero)
        // .zero == CGRect(x: 0, y: 0, width: 100, height: 100)
        // 이미지 뷰는 하위 뷰를 가지고 있어서 계층 구조상 필요한 코드지만 어차피 추후에 제약조건으로 이미지 크기 다시 잡음
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
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            print("constraints")
            make.size.equalTo(200)
            make.center.equalTo(view)
        }
        
    }
    

}

extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        let row = list[indexPath.row]
        cell.label.text = row.text
        cell.label.numberOfLines = row.isExpand ? 0 : 2 //2.
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        isExpand.toggle()
        list[indexPath.row].isExpand.toggle()
//        tableView.reloadData()
        tableView.reloadRows(at: [indexPath], with: .automatic) // IndexPath(row: 3, section: 0) 특정 셀만 갱신하는 것도 가능
    }
    
    
}
