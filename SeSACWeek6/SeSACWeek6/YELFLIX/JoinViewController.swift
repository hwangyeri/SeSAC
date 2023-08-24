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
        view.tintColor = .black
        view.backgroundColor = .white
        view.titleLabel?.font = .boldSystemFont(ofSize: 15)
        view.layer.cornerRadius = 6
        return view
    }()
    
    let additionalInfoLabel = {
        let view = UILabel()
        view.text = "추가 정보 입력"
        view.font = .systemFont(ofSize: 16)
        view.textColor = .white
        return view
    }()
    
    let toggleSwitch = {
        let view = UISwitch()
        view.setOn(true, animated: true)
        view.onTintColor = .systemRed
        view.thumbTintColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for item in UIFont.familyNames {
//            print("=== item ====")
//            for name in UIFont.fontNames(forFamilyName: item) {
//                print("==== \(name)")
//            }
//        }
        
        view.backgroundColor = .black
       
        let subviews: [UIView] = [
            yelflixLabel, emailTextField, passwordTextField, nicknameTextField, locationTextField, recommendCodeTextField, joinButton, additionalInfoLabel, toggleSwitch
        ]
        
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    
        setupConstraints()
    }
    
    
    func setupConstraints() {
        
        yelflixLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(80)
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