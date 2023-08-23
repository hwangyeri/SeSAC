//
//  Examlple1ViewController.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/22.
//

import UIKit
import SnapKit

class Examlple1ViewController: UIViewController {
    
    let photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleTextField = {
        let view = UITextField()
        view.borderStyle = .line
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "제목을 입력해주세요"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let dateTextField = {
        let view = UITextField()
        view.borderStyle = .line
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "날짜를 입력해주세요"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let memoTextField = {
        let view = UITextField()
        view.borderStyle = .line
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        [photoImageView, titleTextField, dateTextField, memoTextField].forEach {
            view.addSubview($0)
        }
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        photoImageView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.top.equalTo(view)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(view).multipliedBy(0.3)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(photoImageView.snp.horizontalEdges)
            make.height.equalTo(view).multipliedBy(0.07)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(photoImageView.snp.horizontalEdges)
            make.height.equalTo(view).multipliedBy(0.07)
        }
        
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(photoImageView.snp.horizontalEdges)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        
    }
    

}
