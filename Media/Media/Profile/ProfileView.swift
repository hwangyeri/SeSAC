//
//  ProfileView.swift
//  Media
//
//  Created by 황예리 on 2023/08/29.
//

import UIKit

class ProfileView: BaseView {
    
    let profileImageButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "person.circle"), for: .normal)
        return view
    }()
    
    let nameLabel = {
        let view = ProfileLabel()
        view.text = "이름"
        return view
    }()
    
    let nameButton = {
        let view = ProfileButton()
        view.setTitle("이름을 입력하세요.", for: .normal)
        return view
    }()
    
    let userNameLabel = {
        let view = ProfileLabel()
        view.text = "사용자 이름"
        return view
    }()
    
    let userNameButton = {
        let view = ProfileButton()
        view.setTitle("사용자 이름을 입력하세요.", for: .normal)
        return view
    }()
    
    let genderLabel = {
        let view = ProfileLabel()
        view.text = "성별"
        return view
    }()
    
    let genderButton = {
        let view = ProfileButton()
        view.setTitle("성별을 입력하세요.", for: .normal)
        return view
    }()
    
    override func configureView() {
        [profileImageButton, nameLabel, nameButton, userNameLabel, userNameButton, genderLabel, genderButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        profileImageButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.centerX.equalTo(self)
            make.size.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(profileImageButton.snp.bottom).offset(30)
            make.width.equalTo(self).multipliedBy(0.2)
        }
        
        nameButton.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
            make.top.bottom.equalTo(nameLabel)
            make.width.equalTo(self).multipliedBy(0.7)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.width.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
        }
        
        userNameButton.snp.makeConstraints { make in
            make.leading.equalTo(userNameLabel.snp.trailing).offset(10)
            make.top.bottom.equalTo(userNameLabel)
            make.width.equalTo(nameButton)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.width.equalTo(nameLabel)
            make.top.equalTo(userNameLabel.snp.bottom).offset(30)
        }
        
        genderButton.snp.makeConstraints { make in
            make.leading.equalTo(genderLabel.snp.trailing).offset(10)
            make.top.bottom.equalTo(genderLabel)
            make.width.equalTo(nameButton)
        }
        
    }
    
    
}
