//
//  UserNameViewController.swift
//  Media
//
//  Created by 황예리 on 2023/08/30.
//

import UIKit

class UserNameViewController: BaseViewController {
    
    let headerLabel = {
        let view = UILabel()
        view.text = "사용자 이름"
        return view
    }()
    
    let textField = {
        let view = UITextField()
        view.placeholder = "사용자 이름을 입력해주세요."
        view.clearButtonMode = .whileEditing
        return view
    }()
    
    //Delegate - 2
    var delegate: PassDataDelegate?
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(headerLabel)
        view.addSubview(textField)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //Delegate - 3
        delegate?.receiveDate(userName: textField.text!)
    }
    
    @objc func doneButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    

}
