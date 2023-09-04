//
//  DetailViewController.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {
    
    static let identifier = "DetailViewController"
    var naviTitle: String?
    var selectedMovie: Movie?
    let placeholderText = " 메모장 입니다. 😎"
    var contents: String?
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var mainTitleLable: UILabel!
    @IBOutlet var subTitleButton: UIButton!
    @IBOutlet var rateLable: UILabel!
    @IBOutlet var reviewButton: UIButton!
    @IBOutlet var headerLable: UILabel!
    @IBOutlet var overviewLable: UILabel!
    @IBOutlet var memoTextView: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        memoTextView.delegate = self
        
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        let chevron = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: chevron, style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black

        title = naviTitle
        
        if let selectedMovie = selectedMovie {
            
            let header = "기본 정보"
            var rate = "평균 ⭑\(selectedMovie.rate)"
            
            posterImageView.image = UIImage(named: selectedMovie.imageName)
            posterImageView.layer.cornerRadius = 12
            
            mainTitleLable.text = selectedMovie.title
            mainTitleLable.font = .boldSystemFont(ofSize: 18)
            
            subTitleButton.setTitle(selectedMovie.releaseDate, for: .normal)
            subTitleButton.tintColor = .black
            subTitleButton.titleLabel?.font = .systemFont(ofSize: 15)
            
            headerLable.text = header
            headerLable.font = .boldSystemFont(ofSize: 15)
            
            rateLable.text = rate
            rateLable.font = .boldSystemFont(ofSize: 14)
            rateLable.textColor = .darkGray
            
            reviewButton.setTitle("(4명)", for: .normal)
            reviewButton.tintColor = .lightGray
            reviewButton.titleLabel?.font = .boldSystemFont(ofSize: 13)
            
            overviewLable.text = selectedMovie.overview
            overviewLable.numberOfLines = 0
            
            memoTextView.text = placeholderText
            memoTextView.textColor = .lightGray
            memoTextView.backgroundColor = .systemGray6
        }
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        print(#function)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
   
}
