//
//  DetailViewController.swift
//  PhotoGramRealm
//
//  Created by 황예리 on 2023/09/05.
//

import UIKit
import SnapKit
import RealmSwift

class DetailViewController: BaseViewController {
    
    var data: DiaryTable?
    
    let realm = try! Realm()

    let titleTextField: WriteTextField = {
        let view = WriteTextField()
        view.textColor = .white
        view.attributedPlaceholder = NSAttributedString(string: "제목을 입력해주세요", attributes: [.foregroundColor: UIColor.white])
        return view
    }()
    
    let contentTextField: WriteTextField = {
        let view = WriteTextField()
        view.textColor = .white
        view.attributedPlaceholder = NSAttributedString(string: "날짜를 입력해주세요", attributes: [.foregroundColor: UIColor.white])
        return view
    }()
    
    let repository = DiaryTableRepository()
    
    override func configure() {
        super.configure()
        view.backgroundColor = .black
        view.addSubview(titleTextField)
        view.addSubview(contentTextField)
        
        guard let data = data else { return }
        
        titleTextField.text = data.diaryTitle
        contentTextField.text = data.contents
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(editButtonClicked))
    }
    
    @objc func editButtonClicked() {
        print("EditButton Clicked")
        
        //Realm Update
        guard let data = data else { return }
        
        repository.updateItem(id: data._id, title: titleTextField.text!, contents: contentTextField.text!)
        
//        let item = DiaryTable(value: ["_id": data._id, "diaryTitle": titleTextField.text!, "diaryContents": contentTextField.text!]) // value 변경하고 싶은 데이터 자리
        
//        do {
//            try realm.write {
//                realm.add(item, update: .modified) // 트랜잭션에게 수정해달라고 요청
//                // 특정 레코드의 값을 바꾸려고 할때, modified 로 추가하는 거야 ~ 라고 명시
//            }
//        } catch {
//            print("")
//        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func setConstraints() {
        
        titleTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.center.equalTo(view)
        }
        
        contentTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(60)
        }
        
    }
    

}
