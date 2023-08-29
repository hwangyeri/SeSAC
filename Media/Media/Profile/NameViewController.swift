//
//  NameViewController.swift
//  Media
//
//  Created by 황예리 on 2023/08/30.
//

import UIKit

class NameViewController: BaseViewController {
    
    let headerLabel = {
        let view = UILabel()
        view.text = "이름"
        return view
    }()
    
    let textField = {
        let view = UITextField()
        view.placeholder = "이름을 입력해주세요."
        view.clearButtonMode = .whileEditing
        return view
    }()
    
    //Closure - 1
    var completionHandler: ((String) -> Void)?
    
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
        //Closure - 2
        completionHandler?(textField.text!)
    }
    
    @objc func doneButtonClicked() {
        //completionHandler?(textField.text!)
        navigationController?.popViewController(animated: true)
    }
    
    
}
