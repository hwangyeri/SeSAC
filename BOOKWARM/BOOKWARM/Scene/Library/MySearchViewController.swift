//
//  MySearchViewController.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit

class MySearchViewController: UIViewController, UISearchBarDelegate {
    
    let movieInfo = MovieInfo()
    
    lazy var movieTitles = movieInfo.getMovieTitles()
    
    @IBOutlet var collectionView: UICollectionView!
    
    let searchBar = UISearchBar()
    let placeholderText = "검색어를 입력해주세요!"
    var searchResultList: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        
        searchBar.placeholder = placeholderText
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
        
        configureViewLayout()
        
        let nib = UINib(nibName: MySearchCollectionViewCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: MySearchCollectionViewCell.reuseIdentifier)
        
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
        
        collectionView.reloadData()
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
        
        collectionView.reloadData()
    }
    
    
}

extension MySearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MySearchCollectionViewCell.reuseIdentifier, for: indexPath) as? MySearchCollectionViewCell else { return UICollectionViewCell() }
        cell.mainTitleLable.text = movieInfo.movie[indexPath.row].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: DetailViewController.reuseIdentifier) as! DetailViewController
        let selectedMovie = movieInfo.movie[indexPath.row]
        
        vc.selectedMovie = selectedMovie
        vc.naviTitle = movieInfo.movie[indexPath.row].title
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 2)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing

        collectionView.collectionViewLayout = layout
        collectionView.isPrefetchingEnabled = true
    }
    
    
}
