//
//  DetailViewController.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var authorsButton: UIButton!
    @IBOutlet var publisherLable: UILabel!
    @IBOutlet var headerLable: UILabel!
    @IBOutlet var contentsLable: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var memoTextView: UITextView!
    
    var naviTitle: String?
    var selectedBook: BookTable? // 선택한 셀의 tasks[indexPath.row]
    let placeholderText = " 메모장을 자유롭게 사용해보세요!"
    let repositoy = BookTableRepository()
    var saveButton: UIBarButtonItem!
    var trashButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.delegate = self
        
        let nib = UINib(nibName: MySearchCollectionViewCell.reuseIdentifier, bundle: nil)
        let chevron = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: chevron, style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black

        title = naviTitle
        
        guard let selectedBook = selectedBook else { return }
        
        thumbnailImageView.image = loadImageFromDocument(fileName: "yeri_\(selectedBook._id).jpg")
        titleLable.text = selectedBook.bookTitle
        authorsButton.setTitle("\(selectedBook.bookAuthors)", for: .normal)
        publisherLable.text = selectedBook.bookPublisher
        dateLabel.text = "도서 출간일: \(dateFormatter())"
        contentsLable.text = selectedBook.bookContents
        
        if selectedBook.bookMemo != nil {
            memoTextView.text = selectedBook.bookMemo
        } else {
            memoTextView.text = placeholderText
        }
        
        configureView()
        setupAppearance()
        setupToolBar()
        
        print(memoTextView.text, "---------")
    }
    
    func dateFormatter() -> String {
        guard let date = selectedBook?.bookDateTime else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
    }
    
    func setupToolBar() {
        
        self.navigationController?.isToolbarHidden = false
        
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonClicked))
        trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashButtonClicked))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        var items = [UIBarButtonItem]()

        [trashButton, flexibleSpace, saveButton].forEach {
            items.append($0)
        }

        self.toolbarItems = items
    }
    
    func setupAppearance() {
        
        let appearance = UIToolbarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6
        
        navigationController?.toolbar.scrollEdgeAppearance = appearance
    }
    
    func configureView() {
        
        headerLable.text = "작품 소개"
        headerLable.font = .boldSystemFont(ofSize: 14)
        thumbnailImageView.layer.cornerRadius = 12
        titleLable.font = .boldSystemFont(ofSize: 16)
        titleLable.numberOfLines = 0
        authorsButton.tintColor = .black
        authorsButton.titleLabel?.font = .systemFont(ofSize: 15)
        publisherLable.font = .systemFont(ofSize: 15)
        publisherLable.textColor = .darkGray
        dateLabel.textColor = .darkGray
        dateLabel.font = .systemFont(ofSize: 13)
        contentsLable.numberOfLines = 0
        contentsLable.textAlignment = .left
        contentsLable.font = .systemFont(ofSize: 13)
        memoTextView.textColor = .black
        memoTextView.backgroundColor = .systemGray6
        likeButton.tintColor = .systemPink
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
    @objc func saveButtonClicked() {
        
        //Realm Update
        guard let data = selectedBook else { return }
        
        guard let memoText = memoTextView.text, memoText != placeholderText else { // 예외처리
            return self.showAlertMessage(title: "메모의 내용을 입력해주세요...😅")
        }
        
        repositoy.updateItem(id: data._id, memo: memoTextView.text)
        
        memoTextView.text = memoTextView.text
        
        self.showAlertMessage(title: "메모가 저장되었습니다!")
    }
    
    @objc func trashButtonClicked() {
        
        let alert = UIAlertController(title: "정말로 삭제하실 건가요? 🥹", message: nil, preferredStyle: .alert)
        
        let delete = UIAlertAction(title: "삭제", style: .destructive) {_ in
            
            //Realm Delete
            guard let data = self.selectedBook else { return }

            self.removeImageFromDocument(fileName: "yeri_\(data._id).jpg")
            self.repositoy.deleteItem(data)
            
            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(delete)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        print(#function)
    }
    
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "" {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
        
//        //FIXME: 메모가 빈값("")인 경우 placeholderText 안보임, 메모가 있었다가 다 지우고 저장한 경우
//        guard let memo = textView.text, !memo.isEmpty, memo != "" else { return }
//
//        textView.text = placeholderText
//        textView.textColor = .lightGray
    }
    
}
