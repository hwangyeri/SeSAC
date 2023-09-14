//
//  AddViewController.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import SnapKit
import RealmSwift

class AddViewController: BaseViewController {
     
     let userImageView: PhotoImageView = {
         let view = PhotoImageView(frame: .zero)
         return view
     }()
     
     let titleTextField: WriteTextField = {
         let view = WriteTextField()
         view.textColor = .white
         view.attributedPlaceholder = NSAttributedString(string: "제목을 입력해주세요", attributes: [.foregroundColor: UIColor.white])
         return view
     }()
     
     let dateTextField: WriteTextField = {
         let view = WriteTextField()
         view.textColor = .white
         view.attributedPlaceholder = NSAttributedString(string: "날짜를 입력해주세요", attributes: [.foregroundColor: UIColor.white])
         return view
     }()
     
     let contentTextView: UITextView = {
         let view = UITextView()
         view.font = .systemFont(ofSize: 14)
         view.layer.borderWidth = Constants.Desgin.borderWidth
         view.layer.borderColor = Constants.BaseColor.border
         view.layer.cornerRadius = Constants.Desgin.cornerRadius
         return view
     }()
     
     lazy var searchImageButton: UIButton = {
         let view = UIButton()
         view.setImage(UIImage(systemName: "photo"), for: .normal)
         view.tintColor = Constants.BaseColor.text
         view.backgroundColor = Constants.BaseColor.point
         view.layer.cornerRadius = 25
         view.addTarget(self, action: #selector(searchImageButtonClicked), for: .touchUpInside)
         return view
     }()
    
    lazy var searchWebButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "web"), for: .normal)
        view.tintColor = Constants.BaseColor.text
        view.backgroundColor = Constants.BaseColor.point
        view.layer.cornerRadius = 25
        view.addTarget(self, action: #selector(searchWebButtonClicked), for: .touchUpInside)
        return view
    }()
      
    var fullURl: String?
    
    let repository = DiaryTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad() //안하는 경우 문제 발생함
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
    }
    
    @objc func saveButtonClicked() {
        
        // 식판 만들기 // 조건 처리, nil 나중에 수정 예정 ex. 제목은 두글자 이상
        let task = DiaryTable(diaryTitle: titleTextField.text!, diaryDate: Date(), diaryContents: contentTextView.text, diaryPhoto: fullURl) // 업데이트한 fullURl 저장
        
        repository.createItem(task)
        
        if userImageView.image != nil {
            saveImageToDocument(fileName: "yeri_\(task._id).jpg", image: userImageView.image!) // 램에 직접 데이터 저장
        }
          
        navigationController?.popViewController(animated: true)
    }
    
    @objc func searchImageButtonClicked() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc func searchWebButtonClicked() {
        let vc = SearchViewController()
        vc.didSelectItemHandler = { [weak self] value in
            
            self?.fullURl = value // 넘겨받은 데이터 변수에 업데이트
            
            DispatchQueue.global().async {
                if let url = URL(string: value), let data = try? Data(contentsOf: url ) {
                    
                    DispatchQueue.main.async {
                        self?.userImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        present(vc, animated: true)
    }
    
    override func configure() {
        super.configure()
        
        [userImageView, titleTextField, dateTextField, contentTextView, searchImageButton, searchWebButton].forEach {
            view.addSubview($0)
        }

    }
    
    override func setConstraints() {
          
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(view.snp.width).multipliedBy(0.55)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(12)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(55)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(12)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(55)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(12)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
        }
        
        searchImageButton.snp.makeConstraints { make in
            make.trailing.equalTo(userImageView.snp.trailing).offset(-12)
            make.bottom.equalTo(userImageView.snp.bottom).offset(-12)
            make.width.height.equalTo(50)
        }
        
        searchWebButton.snp.makeConstraints { make in
            make.trailing.equalTo(searchImageButton.snp.leading).offset(-12)
            make.bottom.equalTo(userImageView.snp.bottom).offset(-12)
            make.width.height.equalTo(50)
        }
    }
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            userImageView.image = image
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
