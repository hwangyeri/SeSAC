//
//  AddViewController.swift
//  PhotoGram
//
//  Created by 황예리 on 2023/08/28.
//

import UIKit
import SeSACFramework

//Protocol 값 전달 1. // 부하직원 등록
protocol PassDataDelegate {
    func receiveDate(date: Date)
}

// 1. 딜리게이트 구성
protocol PassImageDelegate {
    func receiveImage(image: UIImage)
}

class AddViewController: BaseViewController {
    
    let mainView = AddView()
    
    override func loadView() { //viewDidLoad보다 먼저 호출됨, super 메서드 호출 X // 애플이 만들어둔거 말고 내가 만든 걸로 쓸게
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name("SelectImage"), object: nil) // addObserver는 신호만 받음, 신호 받았을때 뭐할지는 selector로 별도 구현
        
//        ClassOpenExample.publicExample()
//        ClassPublicExample.publicExample()
        
        APIService.shared.callRequest()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("========", #function)
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: .selectImage, object: nil)
        
        //sesacShowActivityViewController(image: UIImage(systemName: "star")!, url: "hello", text: "hi")
//        sesacShowAlert(title: <#T##String#>, message: <#T##String#>, buttonTitle: <#T##String#>, buttonAction: <#T##(UIAlertAction) -> Void#>)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("SelectImage"), object: nil)
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        print("========", #function)
        print(notification.userInfo?["name"])
        print(notification.userInfo?["sample"])
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }

    override func configureView() {
        super.configureView()
        print("Add configureView")
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside) // View Setting 환경설정과 관련됨
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.searchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonClicked), for: .touchUpInside)
        mainView.contentButton.addTarget(self, action: #selector(contentButtonClicked), for: .touchUpInside)
        
        APIService.shared.callRequest()
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        print("Add setConstraints")
    }
    
    @objc func searchButtonClicked() {
        let word = ["Apple", "Banana", "Cookie", "Cake", "Sky"]
        
        NotificationCenter.default.post(name: NSNotification.Name("RecommendKeyword"), object: nil, userInfo: ["word": word.randomElement()!])
        
        present(SearchViewController(), animated: true)
        //navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    @objc func dateButtonClicked() {
        //Protocol 값 전달 5.
        let vc = DateViewController()
        vc.delegate = self // 너 부하직원 있지? 부하직원이 할 수 있는 일을 내가 대신 할게 ~
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchProtocolButtonClicked() {
        // 5.
        let vc = SearchViewController()
        vc.delegate = self
        
        present(vc, animated: true)
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func titleButtonClicked() {
        let vc = TitleViewController()
        
        //Closure - 3
        vc.completionHandler = { title, age, push  in
            self.mainView.titleButton.setTitle(title, for: .normal)
            print("completionHandler", age, push)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func contentButtonClicked() {
        let vc = ContentViewController()
        
        vc.completionHandler = { text in // in 을 기준으로 헤더랑 내용?이 나뉨
            self.mainView.contentButton.setTitle(text, for: .normal)
            print("completionHandler")
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

//Protocol 값 전달 4. // 실제로 수행할 수 있는 요소
extension AddViewController: PassDataDelegate {
    
    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
}

extension AddViewController: PassImageDelegate {
    // 4.
    func receiveImage(image: UIImage) {
        mainView.photoImageView.image = image
    }
}
