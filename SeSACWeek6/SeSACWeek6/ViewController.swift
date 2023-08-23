//
//  ViewController.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/21.
//

import UIKit

//1. 객체 얹이고, 레이아웃 잡고, 아웃렛 연결, 속성 조절

//1. 뷰객체 프로퍼티 선언 (클래스 인스턴스 생성)
//2. 명시적으로 루트뷰에 추가
//3. 크기와 위치 정의
//4. 속성 정의
//=> Frame 한계
//=> AutoResizingMask, AutoLayout => 스토리보드 대응
//=> NSLayoutConstraints => 코드베이스 대응, iOS 6
    //1. isActive
    //2. addConstrains
//=> NSLayoutAnchor, iOS 9

class ViewController: UIViewController {
    
    let emailTextField = UITextField() //1.
    let passwordTextField = UITextField()
    let signButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(emailTextField) //2.
        view.addSubview(passwordTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false // 오토리사이징 설정을 쓰지않겠다
        
        emailTextField.frame = CGRect(x: 50, y: 80, width: UIScreen.main.bounds.width - 100, height: 50)
        
        emailTextField.backgroundColor = .lightGray
        emailTextField.isSecureTextEntry = true
        emailTextField.keyboardType = .numberPad
        emailTextField.placeholder = "nickname ..."
        
        //isActive 방식
//        NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50).isActive = true //레이아웃 활성화
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: 50).isActive = true
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50).isActive = true
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 50).isActive = true
        
        //addConstrains 방식
        let leading = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50)
        
        let trailing = NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: 50)
        
        let height = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        
        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 50)
        
        view.addConstraints([leading, trailing, height, top])
        
        setLayoutAnchor()
    }
    
    func setLayoutAnchor() {
        view.addSubview(signButton)
        signButton.translatesAutoresizingMaskIntoConstraints = false
        
        signButton.backgroundColor = .systemMint
        signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signButton.centerXAnchor.constraint(equalTo: view.centerXAnchor), // X 중앙에 둘거야, 루트뷰가 가진 X랑 똑같다
            signButton.widthAnchor.constraint(equalToConstant: 300),
            signButton.heightAnchor.constraint(equalToConstant: 50),
            signButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) // safeAreaLayoutGuide 없으면 Safe Area 무시한 영역부터 시작
        ])
        
    }
    
    @objc func signButtonClicked() {
        
        let vc = LocationViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true)
    }


}

