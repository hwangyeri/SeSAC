//
//  StudyTableViewController.swift
//  TableViewPractice
//
//  Created by 황예리 on 2023/07/27.
//

import UIKit

class StudyTableViewController: UITableViewController {
    
    
    let studyList = ["변수", "클래스", "유저 디폴트", "열거형", "옵션러 바인딩", "얼럿"]
    let appleList = ["iPhone", "iPad", "AppleWatch"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 60 // 모든 셀에 같은 높이 적용하는 코드
    }
    
    // 섹션의 갯수 numberOfRowsInSection * numberOfSections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Section Title 01" : "Section Title 02"
    }

    //1. 셀 갯수 (필수), 없으면 빌드했을때 안보임
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? studyList.count : appleList.count
    }
    
    //2. 셀 디자인 및 데이터 처리 (필수)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //옵셔널로 뜨는 이유: identifier에 맞는 셀이 있을 수 있기 때문에 옵셔널로 반환을 해줌 > 해제가 필요!
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell")! // Cell 특정
        
        if indexPath.section == 0 {
            cell.textLabel?.text = studyList[indexPath.row]
        } else {
            cell.textLabel?.text = appleList[indexPath.row]
        }
        
        return cell
    }
    
    //3. 셀 높이 : 서비스 구현에 따라 필요한 경우가 많지만, 항상 같은 높이를 셀에서 사용한다면 비효율적일 수 있음!
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 40
        } else {
            return 100
        }
        
    }
    
    
    
}
