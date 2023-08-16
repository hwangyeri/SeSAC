//
//  TrendViewController.swift
//  Media
//
//  Created by 황예리 on 2023/08/12.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct Trend {
    var voteAverage: Int
    var title: String
}

class TrendViewController: UIViewController {
    
    @IBOutlet var trendTableView: UITableView!
    
    var movieList: [Trend] = []
    var result: BoxOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendTableView.delegate = self
        trendTableView.dataSource = self
        
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
                
                //                guard let value = response.value else { return }
                //                print(value)
                //                self.result = response.value // nil error
                //                self.trendTableView.reloadData()
                
                switch response.result {
                case .success(let value):
                    self.result = value
                    self.trendTableView.reloadData()
                    
                case .failure(let error):
                    print("API request error: \(error)")
                }
            }
    }
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier) as? TrendTableViewCell else { return UITableViewCell() }
        
        //        guard !(result!.results.isEmpty) else {
        //            return cell
        //        }
        //
        //        let result = movieList[indexPath.row]
        //        cell.rateLabel.text = "\(result.voteAverage)"
        //        cell.titleLabel.text = result.title
        
        let result = result!.results[indexPath.row]
        cell.rateLabel.text = "\(result.voteAverage)"
        cell.titleLabel.text = result.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let trendCell = tableView.cellForRow(at: indexPath) as? TrendTableViewCell,
              let creditViewController = storyboard?.instantiateViewController(withIdentifier: CreditViewController.identifier) as? CreditViewController else { return }
        
        present(creditViewController, animated: true, completion: nil)
    }
    
    
    
    
}
