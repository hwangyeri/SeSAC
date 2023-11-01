//
//  NicknameViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NicknameViewController: UIViewController {
   
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let infoLabel: UILabel = {
       let label = UILabel()
        label.textColor = Color.black
        label.text = "조건: 2글자 이상 6글자 미만\n조건에 맞게 닉네임을 작성해 주세요."
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let nickname = BehaviorSubject(value: "")
    let buttonHidden = BehaviorSubject(value: true)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "5.닉네임 - 회원가입"
        view.backgroundColor = Color.white
        
        configureLayout()
       
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)

        bind()
    }
    
    func bind() {
        
        buttonHidden
            .bind(to: nextButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        nickname.bind(to: nicknameTextField.rx.text)
            .disposed(by: disposeBag)
        
        nickname
            .map { 1 < $0.count && $0.count < 7 }
            .subscribe(with: self, onNext: { owner, value in
                print("== \(value) ==")
                owner.buttonHidden.onNext(!value)
            })
            .disposed(by: disposeBag)
        
        nicknameTextField.rx.text.orEmpty
            .subscribe { value in
                self.nickname.onNext(value)
            }
            .disposed(by: disposeBag)
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(BirthdayViewController(), animated: true)
    }

    
    func configureLayout() {
        view.addSubview(nicknameTextField)
        view.addSubview(nextButton)
        view.addSubview(infoLabel)
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
         
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
