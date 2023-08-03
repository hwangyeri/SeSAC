//
//  SearchCollectionViewController.swift
//  Diary
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit

class SearchCollectionViewController: UICollectionViewController {
    
    let searchBar = UISearchBar()
    
    let list = ["iOS", "iPad", "Android", "Apple", "Watch", "사과", "사자", "호랑이"]
    var searchList: [String] = ["hhh"] // 서치 결과 리스트 담을 공간

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력해주세요."
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar

        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        setCollectionViewLayout()
    }
    
    
    func setCollectionViewLayout() {
        //cell Estimated size .none으로 인터페이스 빌더에서 설정할 것!
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 4)
        
        layout.itemSize = CGSize(width: width / 3, height: width / 3) // 높이 1:1
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing) // padding
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
        
    }

    //1.
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    //2.
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        cell.backgroundColor = .opaqueSeparator
        cell.contentLable.text = searchList[indexPath.row]
        
        return cell
    }
    

}

extension SearchCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("=======================")
        searchList.removeAll() // 포함되는 내용들만 나오게 필터링, 이전 검색 내역 삭제
        searchBar.text = ""
        
        for item in list {
            if item.contains(searchBar.text!) {
                searchList.append(item)
                print(searchList)
            }
        }
        
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchList.removeAll()
        searchBar.text = ""
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { // 실시간 검색
        print("============")
        searchList.removeAll()
        
        for item in list {
            if item.contains(searchBar.text!) {
                searchList.append(item)
                print(searchList)
            }
        }
        
        collectionView.reloadData()
    }
    
}
