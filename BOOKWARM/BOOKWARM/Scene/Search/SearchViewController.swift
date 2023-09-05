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
import RealmSwift

class SearchViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var page = 1
    var isEnd = false
    let placeholderText = "검색어를 입력해주세요!"
    
    var tasks: Results<BookTable>!
    let realm = try! Realm()
    var fullURl: String?
    
    private var bookList: Book = Book(documents: [], meta: Meta(isEnd: false))
    
//    var didSelectItemHandler: ((String) -> Void)?
    
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
    
    func showAlertMessage(title: String, button: String = "확인", handler: (() -> ())? = nil ) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .default) { _ in
            handler?()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        cell.likeButtonTappedHandler = { [weak self] in
            guard let self = self else { return }
            let data = self.bookList.documents[indexPath.row]
            let task = BookTable(bookTitle: data.title, bookAuthors: data.authorsDescriptions, bookContents: data.contents, bookPrice: data.price, bookSalePrice: data.salePrice, bookThumbnail: data.thumbnail!, bookURL: data.url, bookPublisher: data.publisher, bookDateTime: Date(), bookStatus: data.status, bookLiked: true)
            
            try! self.realm.write {
                self.realm.add(task)
                print("Realm Add Succeed")
            }
            
            if let value = data.thumbnail {
                DispatchQueue.global().async {
                    if let url = URL(string: value), let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            guard let savedImage = UIImage(data: data) else { return }
                            self.saveImageToDocument(fileName: "yeri_\(task._id).jpg", image: savedImage)
                        }
                    }
                }
            }
            
            showAlertMessage(title: "내 서재에 저장 되었습니다!")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)

//        let realm = try! Realm()
//        let data = bookList.documents[indexPath.item]
//        let task = BookTable(bookTitle: data.title, bookAuthors: data.authorsDescriptions, bookContents: data.contents, bookPrice: data.price, bookSalePrice: data.salePrice, bookThumbnail: data.thumbnail!, bookURL: data.url, bookPublisher: data.publisher, bookDateTime: Date(), bookStatus: data.status, bookLiked: true)
//
//        try! realm.write {
//            realm.add(task)
//            print("Realm Add Succeed")
//        }
//
//        guard let value = data.thumbnail else { return }
//
//        DispatchQueue.global().async {
//            if let url = URL(string: value), let data = try? Data(contentsOf: url) {
//
//                DispatchQueue.main.async {
//                    guard let savedImage = UIImage(data: data) else { return }
//                    self.saveImageToDocument(fileName: "yeri_\(task._id).jpg", image: savedImage) // 램에 이미지 따로 저장
//                }
//            }
//        }
//
//        showAlertMessage(title: "내 서재에 저장 되었습니다!")
    }
    
}

extension SearchViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if bookList.documents.count - 1 == indexPath.row && page < 10 && !isEnd {
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
