//
//  GenderViewController.swift
//  Media
//
//  Created by 황예리 on 2023/08/30.
//

import UIKit

class GenderViewController: BaseViewController {

    let headerLabel = {
        let view = UILabel()
        view.text = "성별"
        return view
    }()
    
    let textField = {
        let view = UITextField()
        view.placeholder = "성별을 입력해주세요."
        view.clearButtonMode = .whileEditing
        return view
    }()
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(headerLabel)
        view.addSubview(textField)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
    }
    
    override func setConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        textField.snp.makeConstraints { make in
            make.leading.equalTo(headerLabel)
            make.top.equalTo(headerLabel.snp.bottom).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
    
    @objc func saveButtonClicked() {
        //Notification - 1
        NotificationCenter.default.post(name: NSNotification.Name.selectGender, object: nil, userInfo: ["gender": textField.text ?? ""])
        navigationController?.popViewController(animated: true)
    }
    
}
