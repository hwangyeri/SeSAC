//
//  DetailViewController.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"
    var naviTitle: String = "navi Title"
    var selectedMovie: Movie?
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var mainTitleLable: UILabel!
    @IBOutlet var subTitleButton: UIButton!
    @IBOutlet var rateLable: UILabel!
    @IBOutlet var reviewButton: UIButton!
    @IBOutlet var headerLable: UILabel!
    @IBOutlet var overviewLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        let chevron = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: chevron, style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black

        title = naviTitle
        
        if let selectedMovie = selectedMovie {
            
            var header = "기본 정보"
            var rate = "평균 ⭑\(selectedMovie.rate)"
            
            posterImageView.image = UIImage(named: selectedMovie.imageName)
            posterImageView.layer.cornerRadius = 12
            
            mainTitleLable.text = selectedMovie.title
            mainTitleLable.font = .boldSystemFont(ofSize: 20)
            
            subTitleButton.setTitle(selectedMovie.releaseDate, for: .normal)
            subTitleButton.tintColor = .black
            subTitleButton.titleLabel?.font = .systemFont(ofSize: 18)
            
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
            
        }
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    
   
}
