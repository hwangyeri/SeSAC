//
//  ViewController.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static let identifier = "SearchViewController"
    let movieInfo = MovieInfo()
    lazy var movieTitles = movieInfo.getMovieTitles()
    
    @IBOutlet var searchCollectionView: UICollectionView!
    
    let searchBar = UISearchBar()
    let placeholderText = "검색어를 입력해주세요!"
    var searchResultList: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        
        searchBar.placeholder = placeholderText
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
        
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        //collectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        let xmark = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        
    }
    
    
    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        for item in movieTitles {
            if item.contains(searchBar.text!) {
                searchResultList.append(item)
                print(searchResultList)
            }
        }
        //reload
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchResultList.removeAll()
        searchBar.text = ""
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        for item in movieTitles {
            if item.contains(searchBar.text!) {
                searchResultList.append(item)
                print(searchResultList)
            }
        }
        
        //reload
    }
    
    // MARK: - collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        cell.mainTitleLable.text = movieInfo.movie[indexPath.row].title
        
        return cell
    }
    
    
}
