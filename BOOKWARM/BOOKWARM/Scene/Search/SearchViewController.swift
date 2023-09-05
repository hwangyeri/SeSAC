//
//  SearchViewControll.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/08/09.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SearchViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var bookList: Book = Book(documents: [], meta: Meta(isEnd: false))
    
    var page = 1
    var isEnd = false
    let placeholderText = "검색어를 입력해주세요!"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = 200
        
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = placeholderText
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.documents.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier) as? SearchTableViewCell else { return UITableViewCell() }
        let row = bookList.documents[indexPath.row]

        cell.titleLabel.text = row.title
        cell.authorLabel.text = row.authorsDescriptions
        cell.contentLabel.text = row.contents

        if let url = URL(string: bookList.documents[indexPath.row].thumbnail ?? "") {
            cell.bookImageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if bookList.documents.count - 1 == indexPath.row && page < 30 && !isEnd {
                page += 1
                
                APIService.shared.searchBook(text: searchBar.text!, page: page) { data in
                    guard let data = data else { return }
                    self.bookList = data
                    print(data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("------- 취소: \(indexPaths) -----")
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        
        page = 1
        bookList.documents.removeAll()
        
        guard let query = searchBar.text else { return }
        
        APIService.shared.searchBook(text: query, page: page) { data in
            guard let data = data else { return }
            self.bookList = data
            print(data)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        bookList.documents.removeAll()
        searchBar.text = ""
    }
    
}
