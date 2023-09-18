//
//  JoinViewController.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/25.
//

import UIKit
import SnapKit

class JoinViewController: UIViewController {
    
    let yelflixLabel = {
        let view = UILabel()
        view.text = "YELFLIX"
        view.textColor = .systemRed
        view.font = UIFont(name: "OTSBAggroB", size: 30)
        return view
    }()
    
    let resultLabel = {
        let view = UILabel()
        view.textColor = .label
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let emailTextField = {
        let view = JoinTextField()
        view.placeholder = "이메일 주소 또는 전화번호"
        return view
    }()

    let passwordTextField = {
        let view = JoinTextField()
        view.placeholder = "비밀번호"
        return view
    }()
    
    let nicknameTextField = {
        let view = JoinTextField()
        view.placeholder = "닉네임"
        return view
    }()
    
    let locationTextField = {
        let view = JoinTextField()
        view.placeholder = "위치"
        return view
    }()
    
    let recommendCodeTextField = {
        let view = JoinTextField()
        view.placeholder = "추천 코드 입력"
        return view
    }()
    
    let joinButton = {
        let view = UIButton()
        view.setTitle("회원가입", for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 15)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.cornerRadius = 6
        return view
    }()
    
    let additionalInfoLabel = {
        let view = UILabel()
        view.text = "추가 정보 입력"
        view.font = .systemFont(ofSize: 16)
        view.textColor = .label
        return view
    }()
    
    let toggleSwitch = {
        let view = UISwitch()
        view.setOn(true, animated: true)
        view.onTintColor = .systemRed
        view.thumbTintColor = .white
        return view
    }()
    
    var viewModel = JoinViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for item in UIFont.familyNames {
//            print("=== item ====")
//            for name in UIFont.fontNames(forFamilyName: item) {
//                print("==== \(name)")
//            }
//        }
        
        view.backgroundColor = .systemBackground
       
        let subviews: [UIView] = [
            yelflixLabel, resultLabel, emailTextField, passwordTextField, nicknameTextField, locationTextField, recommendCodeTextField, joinButton, additionalInfoLabel, toggleSwitch
        ]
        
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    
        setupConstraints()
        
        viewModel.result.bind { text in
            self.resultLabel.text = text
        }
        
        viewModel.email.bind { text in
            self.emailTextField.text = text
        }
        
        viewModel.password.bind { text in
            self.passwordTextField.text = text
        }
        
        viewModel.nickname.bind { text in
            self.nicknameTextField.text = text
        }
        
        viewModel.location.bind { text in
            self.locationTextField.text = text
        }
        
        viewModel.recommendCode.bind { text in
            self.recommendCodeTextField.text = text
        }
        
        viewModel.isValid.bind { bool in
            DispatchQueue.main.async {
                self.joinButton.isEnabled = bool
                self.joinButton.backgroundColor = bool ? .label : .systemBackground
                self.joinButton.setTitleColor(bool ? UIColor.systemBackground : UIColor.systemGray, for: .normal)
            }
        }
        
        emailTextField.addTarget(self, action: #selector(emailTextFieldChanged), for: .editingChanged)
        
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
        
        nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldChanged), for: .editingChanged)
        
        locationTextField.addTarget(self, action: #selector(locationTextFieldChanged), for: .editingChanged)
        
        recommendCodeTextField.addTarget(self, action: #selector(recommendCodeTextFieldChanged), for: .editingChanged)
        
        joinButton.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
    }
    
    @objc func emailTextFieldChanged() {
        viewModel.email.value = emailTextField.text!
        viewModel.checkValidation()
    }
    
    @objc func passwordTextFieldChanged() {
        viewModel.password.value = passwordTextField.text!
        viewModel.checkValidation()
    }
    
    @objc func nicknameTextFieldChanged() {
        viewModel.nickname.value = nicknameTextField.text!
        viewModel.checkValidation()
    }
    
    @objc func locationTextFieldChanged() {
        viewModel.location.value = locationTextField.text!
        viewModel.checkValidation()
    }
    
    @objc func recommendCodeTextFieldChanged() {
        viewModel.recommendCode.value = recommendCodeTextField.text!
        viewModel.checkValidation()
    }
    
    @objc func joinButtonTapped() {
        print(#function)
        viewModel.savedUserDefaults {
            let vc = HomeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setupConstraints() {
        
        yelflixLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(80)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(180)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(250)
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(view).multipliedBy(0.045)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp_bottomMargin).offset(30)
            make.size.equalTo(emailTextField)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp_bottomMargin).offset(30)
            make.size.equalTo(emailTextField)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nicknameTextField.snp_bottomMargin).offset(30)
            make.size.equalTo(emailTextField)
        }
        
        recommendCodeTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationTextField.snp_bottomMargin).offset(30)
            make.size.equalTo(emailTextField)
        }
        
        joinButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(recommendCodeTextField.snp_bottomMargin).offset(30)
            make.width.equalTo(emailTextField)
            make.height.equalTo(view).multipliedBy(0.05)
        }
        
        additionalInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(joinButton.snp_bottomMargin).offset(30)
            make.leading.equalTo(joinButton)
        }
        
        toggleSwitch.snp.makeConstraints { make in
            make.top.equalTo(additionalInfoLabel)
            make.trailing.equalTo(joinButton.snp_trailingMargin)
        }
        
        
    }

}
