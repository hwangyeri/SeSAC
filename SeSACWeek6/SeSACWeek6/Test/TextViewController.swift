//
//  TextViewController.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/22.
//

import UIKit
import SnapKit

class TextViewController: UIViewController {
    
    //lazy var photoImageView = setImageView() // 2. lazy var 초기화 시점 미뤄주기
    
    let photoImageView = { // 3. 이름 없는 함수로 호출
        let view = UIImageView()
        view.backgroundColor = .systemIndigo
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleTextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "제목을 입력해주세요..!"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(photoImageView)
        view.addSubview(titleTextField)
        setupConstraints()
        
        for item in [photoImageView, titleTextField] { // 단순 실행 반복구문
            view.addSubview(item)
        }
        
        [photoImageView, titleTextField].forEach { // 클로저 구문
            view.addSubview($0)
        }
        
        
    }

    
    func setImageView() -> UIImageView { // 1. static 타입 메서드로 바꾸기
        let view = UIImageView()
        view.backgroundColor = .systemIndigo
        view.contentMode = .scaleAspectFill
        return view
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view).multipliedBy(0.3)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20) // == make.leading.equalTo(view).inset(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
    

}
