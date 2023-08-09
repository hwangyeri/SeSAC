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
}

class BookViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var bookList: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    

    func callRequest() {
        let url = "https://dapi.kakao.com/v3/search/book"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension BookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier) as! BookTableViewCell
        let row = bookList[indexPath.row]
        
//        cell.titleLabel
//        cell.authorLabel
//        cell.contentLabel
        return cell
    }
    
}

extension BookViewController: UISearchBarDelegate {
    
}
