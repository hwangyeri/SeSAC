//
//  BookViewController.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/08/09.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct Book {
    let title: String
    let author: String
    let content: String
    let price: Int
    let thumbnail: String
}

class BookViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var bookList: [Book] = []
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
    

    func callRequest(query: String, page: Int) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)&size=10&page=\(page)"
        let header: HTTPHeaders = ["Authorization" : "KakaoAK \(APIKey.kakaoKey)"]
        print(url)
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                print(response.response?.statusCode)
                
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    
                    self.isEnd = json["meta"]["is_end"].boolValue
                    print(json["meta"]["is_end"].boolValue)
                    
                    for item in json["documents"].arrayValue {
                        
                        let title = item["title"].stringValue
                        let authorArray = item["authors"].arrayValue
                        let author = authorArray.compactMap { $0.stringValue }.joined(separator: ", ")
                        let content = item["contents"].stringValue
                        let price = item["price"].intValue
                        let thumbnail = item["thumbnail"].stringValue
                        
                        let data = Book(title: title, author: author, content: content, price: price, thumbnail: thumbnail) //error
                        
                        self.bookList.append(data)
                    }
                    
                    self.tableView.reloadData()
                    
                } else {
                    print("문제가 발생했어요, 잠시 후에 다시 시도해주세요!")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension BookViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier) as? BookTableViewCell else { return BookTableViewCell() }
        let row = bookList[indexPath.row]
        
        cell.titleLabel.text = row.title
        cell.authorLabel.text = row.author
        cell.contentLabel.text = row.content
        
        if let url = URL(string: bookList[indexPath.row].thumbnail) {
            cell.bookImageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if bookList.count - 1 == indexPath.row && page < 50 && !isEnd {
                page += 1
                callRequest(query: searchBar.text!, page: page)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("------- 취소: \(indexPaths) -----")
    }
    
    
}

extension BookViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        page = 1
        bookList.removeAll()
        
        guard let query = searchBar.text else { return }
        callRequest(query: searchBar.text!, page: page)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        bookList.removeAll()
        searchBar.text = ""
    }
    
}
