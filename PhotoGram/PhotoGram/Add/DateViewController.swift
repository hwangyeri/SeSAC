//
//  DateViewController.swift
//  PhotoGram
//
//  Created by 황예리 on 2023/08/29.
//

import UIKit

class DateViewController: BaseViewController {
    
    let mainView = DateView()
    
    //Protocol 값 전달 2. // 부하직원 주인 // 어느 시점에 어떤 데이터를 넘겨줄지 결정
    var delegate: PassDataDelegate?
    
    override func loadView() { // 루트뷰를 바꿔줌
        self.view = mainView
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //Protocol 값 전달 3. // 언제 부하직원에게 일을 시킬지
        delegate?.receiveDate(date: mainView.picker.date)
    }
    
}
