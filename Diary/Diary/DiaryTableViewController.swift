//
//  DiaryTableViewController.swift
//  Diary
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit

class DiaryTableViewController: UITableViewController {
    
    var list = ["text1text1text1text1text1text1text1text1text1text1text1text1text1ㅍ", "text2", "text3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        
        //XIB로 테이블뷰셀을 생성할 경우, 테이블뷰에 사용할 셀을 등록해주는 과정이 필요!
        let nib = UINib(nibName: DiaryTableViewCell.identifier, bundle: nil) // nil로 설정하면 기본적인 main bundle 주소가 나옴
        tableView.register(nib, forCellReuseIdentifier: DiaryTableViewCell.identifier)
        
//        tableView.backgroundColor = .clear

        //Dynamic Height: 1. automaticDimension, 2.lable numberOfLines, 3. AutoLayout(여백)
        tableView.rowHeight = UITableView.automaticDimension //자동으로 높이 설정
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.identifier) as? DiaryTableViewCell else {
            // as? DariyTableViewCell 한단계 낮은 캐스팅을 위해서 필요함
            // guard 문으로 예외처리를 해서 앱이 안꺼짐
            return UITableViewCell() // 함수가 아닌 초기화
        }
        
        cell.contentLable.numberOfLines = 0
        cell.contentLable.text = list[indexPath.row]
        cell.backgroundColor = .clear
        
        return cell
    }
    
    //1. System Delete
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //2. System Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        list.remove(at: indexPath.row) // 데이터랑 뷰는 따로 놀아서 데이터가 바뀌면 뷰에도 적용을 해줘야함
        tableView.reloadData() // 따라서, 갱신 필요
    }
    
//    //Custom Swipe
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        UISwipeActionsConfiguration(actions: <#T##[UIContextualAction]#>)
//    }
//
//    //Custom Swipe
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//    }
    
    // 셀을 선택했을때 실행하는 함수
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //DetailViewController(UIViewController) 생성해서 present 해보기!
        //let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard?.instantiateViewController(withIdentifier: AddViewController.identifier) as! AddViewController
        //IF, let vc = DetailViewController() // Swift Flie만 가져오는 것, 구현한 나머지는 못가져옴
        
        //Pass Data
        //2. vc가 가지고 있는 프로퍼티에 데이터 추가
        //vc.contents = list[indexPath.row]
        vc.type = .edit
        vc.contents = list[indexPath.row]
        
        //값 전달 시 아웃렛을 활용할 수는 없음
        //vc.contentsLable.text = list[indexPath.row]
        // contentTextView nil 상태라서 에러, 초기화 시점이 다름
        //vc.contentTextView.text = list[indexPath.row]
        
        
//        vc.modalTransitionStyle = .crossDissolve
//        vc.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(vc, animated: true) //인터페이스 빌더에 네비게이션 컨트롤러가 임베드 되어 있어야만 Push가 동작합니다.
        // 인터페이스에서 show, 코드상에서는 push, SwiftUI에서는 navigation
        // NavigationController 필수
        
    }
    
    
    @IBAction func ClickedAddButton(_ sender: UIBarButtonItem) {
        
        //1. 스토리보드 파일 찾기
        //let sb = UIStoryboard(name: "Main", bundle: nil) // == storyboard?
        //2. 스토리보드 파일 내 뷰컨트롤러 찾기
        let vc = storyboard?.instantiateViewController(withIdentifier: AddViewController.identifier) as! AddViewController // 강제 타입캐스팅
        
        //2-1(옵션). 네비게이션 컨트롤러가 있는 형태(제목바)로 Present 하고 싶은 경우
        //nav를 사용한다면, present와 화면 전환 방식도 nav로 수정 해주어야 함!!
        let nav = UINavigationController(rootViewController: vc)
        
        vc.type = .add
        
        //3. 화면 전환 방식 설정
//        vc.modalTransitionStyle = .crossDissolve //madal animation
            nav.modalPresentationStyle = .fullScreen //modal form 형식
        
        //4. 화면 띄우기
        present(nav, animated: true) //modal
        // 밑에서 위로 띄우는 모달이랑 유사, Alert과 동일
        
    }
    
    @IBAction func searchBarButtonClicked(_ sender: UIBarButtonItem) {
        // Search 아이콘 클릭 시 SearchCollectionViewController Push!
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchCollectionViewController") as! SearchCollectionViewController
        
        navigationController?.pushViewController(vc, animated: true)

    }
    
    
}
