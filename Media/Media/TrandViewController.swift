//
//  TrandViewController.swift
//  Media
//
//  Created by 황예리 on 2023/08/12.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct Trand {
    var voteAverage: Int
    var title: String
}

class TrandViewController: UIViewController {
    
    @IBOutlet var trandTableView: UITableView!
    
    var movieList: [Trand] = []
    var result: BoxOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trandTableView.delegate = self
        trandTableView.dataSource = self
        
        callRequest()
    }
    
    func callRequest() {
        let url = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(APIKey.tmdbKey)"
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(APIKey.tmdbKey)"
        ]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: BoxOffice.self) { response in
                
                guard let value = response.value else { return }
                print(value)
                self.result = response.value
                self.trandTableView.reloadData()
            }
    }
}

extension TrandViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrandTableViewCell.identifier) as? TrandTableViewCell else { return UITableViewCell() }
        
        guard !(result!.results.isEmpty) else {
            return cell
        }
        
        let result = movieList[indexPath.row]
        cell.rateLabel.text = "\(result.voteAverage)"
        cell.titleLabel.text = result.title
        
        return cell
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let trandCell = tableView.cellForRow(at: indexPath) as? TrandTableViewCell,
            let creditViewController = storyboard?.instantiateViewController(withIdentifier: "CreditViewController") as? CreditViewController else { return }
    
            present(creditViewController, animated: true, completion: nil)
        }
    
    
    
    
}
