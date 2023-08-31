//
//  HomeViewController.swift
//  PhotoGram
//
//  Created by 황예리 on 2023/08/31.
//

import UIKit

// protocol 1.
//AnyObject: 클래스에서만 프로토콜을 정의할 수 있도록 제약
protocol HomeViewProtocol: AnyObject {
    // 셀 선택한 걸 넘겨주기
    func didSelectItemAt(indexPath: IndexPath)
}

class HomeViewController: BaseViewController {

    override func loadView() {
        //super.loadView() // 커스텀하게 쓸거면 super 메서드 호출 X
        let view = HomeView()
        // protocol 3.
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function, "*****")
    }
    
    deinit {
        print(self, #function, "======")
    }

}

// protocol 4.
extension HomeViewController: HomeViewProtocol {
    
    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath)
        navigationController?.popViewController(animated: true)
    }
    
}

