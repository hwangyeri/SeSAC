//
//  PhoneViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhoneViewController: UIViewController {
   
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    let buttonColor = BehaviorSubject(value: UIColor.red)
    
    let viewModel = PhoneViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "4.전화번호 - 회원가입"
        view.backgroundColor = Color.white
        
        configureLayout()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        bind()
    }
    
    func bind() {
        
        viewModel.buttonEnabled
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        buttonColor
            .bind(to: nextButton.rx.backgroundColor, phoneTextField.rx.tintColor)
            .disposed(by: disposeBag)
        
        buttonColor
            .map { $0.cgColor }
            .bind(to: phoneTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
        
        viewModel.buttonEnabled
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, isEnable in
                let color = isEnable ? UIColor.blue : UIColor.red
                owner.buttonColor.onNext(color)
                owner.viewModel.buttonEnabled.onNext(isEnable)
            }
            .disposed(by: disposeBag)
        
        viewModel.phone
            .bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        phoneTextField.rx.text.orEmpty
            .bind(to: viewModel.phone)
            .disposed(by: disposeBag)
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(NicknameViewController(), animated: true)
    }

    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
         
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
