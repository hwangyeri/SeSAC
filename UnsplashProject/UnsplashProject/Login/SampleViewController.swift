//
//  SampleViewController.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/12.
//

import UIKit

/*
 
 VC 이 빵빵해지지않게 기능을 분리
 아웃렛, 테이블뷰, 데이터소스 관련 코드는 뺄 수 없음
 list 같은 요소는 뺄 수 있음
 
 */

struct User {
    let name: String
    let age: Int
    
    var introduce: String { // 연산프로퍼티로 코드 개선, 연산프로퍼티는 공간을 차지하고 있지않음
        return "\(name), \(age)살" // "\(data.name), \(data.age)살"
    }
}

class SampleViewController: UIViewController {

    @IBOutlet var tableView: UITableView! // MVC View 의 역할
    
    let viewModel = SampleViewModel() // viewModel 인스턴스 생성
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sample = Observable(1)
        
        // value Int 로 변경
        var number1 = 10
        var number2 = 3
        
        print(number1 - number2) //7
        
        number1 = 3
        number2 = 1
        
        //
        
        var number3 = Observable(10)
        var number4 = Observable(3)
        
        number3.bind { number in
            print("Observable", number3.value - number4.value) // 데이터 변경이 감지되면 프린트해라
        }
        
        number3.value = 100 // 값을 바꾸게 되면 didset 호출, listener 호출
        number3.value = 500 // listener 에 기존 코드를 넣어놔서 프린트 되는 것
        number3.value = 50
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    
}

extension SampleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection // viewModel 이 가진 데이터에 접근 가능해짐
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell")!
        let data = viewModel.cellForRowAt(at: indexPath)
        cell.textLabel?.text = data.introduce // 데이터를 보여주기만 하면 되는 곳이라 데이터 가공은 연산프로퍼티 이용해서 구성 업데이트
        return cell
    }
    
    
}
