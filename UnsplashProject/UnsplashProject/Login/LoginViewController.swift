//
//  LoginViewController.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/12.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let sample = Observable(value: "cookie") // 클래스의 인스턴스를 만들어서 한 곳에 담아줌
//        sample.value
//        sample.value = "cooMon" // 값이 변경되면 신호를 받고싶음
//        sample.value = "gkgkgk" // didset 구문으로 디버그 영역에서 확인 가능해짐, 인지 상태
        
//        let sample = Observable(value: "1234") // value 값 초기화
//
//        sample.bind { text in
//            print(text)
//        }
//
//        sample.value = "5678" // value 에 데이터를 바꿨을때, 역으로 올라가서 다시 프린트 문이 출력
//        sample.value = "9999" // 데이터를 양방향으로 흐르게 만든 것
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        idTextField.addTarget(self, action: #selector(idTextFieldChanged), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(pwTextFieldChanged), for: .editingChanged)
        
        // MVVM 으로 교체
        viewModel.id.bind { text in
            print("Bind \(text)")
            self.idTextField.text = text
            // 데이터가 바뀔때마다 텍스트필드 텍스트를 바꿔줘
        }
        
        viewModel.pw.bind { text in // 루프 돌듯이 흐름이 반복됨
            print("Bind \(text)")
            self.pwTextField.text = text
        }
        
        viewModel.isValid.bind { bool in
            self.loginButton.isEnabled = bool
            // 유효성 검증 통과시 로그인 버튼 활성화
            self.loginButton.backgroundColor = bool ? .green : .lightGray
            // 로그인 버튼 색상 변경
        }

    }
    
    @objc func pwTextFieldChanged() {
        print("===")
        viewModel.pw.value = pwTextField.text! // 바뀐 데이터 -> 뷰모델에게 전달
        viewModel.checkValidation() // 데이터 변경 신호를 전달
    }
    
    @objc func idTextFieldChanged() { // idTextField 값이 바뀔때마다 메서드 실행
        print("===")
        viewModel.id.value = idTextField.text!
        viewModel.checkValidation()
    }
    
    @objc func loginButtonTapped() {
        
        // 로그인 실패하면 버튼이 안눌려서 조건처리 필요 없어짐
//        guard let id = idTextField.text else { return }
//        guard let pw = pwTextField.text else { return }
//
//        if id.count >= 6 && pw == "1234" { // 358,900
//            print("로그인 했어요")
//        } else {
//            print("로그인 실패")
//        }
        
        viewModel.signIn {
            // 로그인 성공시 얼럿 띄우기 기능
            print("로그인 성공했기 때문에 얼럿 띄우기")
            
        }
        
    }
    

}
