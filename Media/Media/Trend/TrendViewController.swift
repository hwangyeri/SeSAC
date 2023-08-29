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

class TrendViewController: BaseViewController {
    
    let trendView = TrendView()
    
    var trendList: BoxOffice = BoxOffice(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TrendAPIManager.shared.callRequest { data in
            self.trendList = data
            //print("*****list.data success", self.trendList)
            self.trendView.tableView.reloadData()
        } failure: {
            print(#function, "error")
        }
        
        configureRightBarButtonItem()
        configureleftBarButtonItem()
    }
    
    func configureRightBarButtonItem() {
        let searchButtonIcon = UIImage(systemName: "magnifyingglass")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: searchButtonIcon, style: .plain, target: self, action: #selector(searchButtonClicked))
    }
    
    func configureleftBarButtonItem() {
        let listButtonIcon = UIImage(systemName: "list.triangle")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: listButtonIcon, style: .plain, target: self, action: #selector(listButtonClicked))
    }
    
    @objc func searchButtonClicked() {
        let vc = storyboard?.instantiateViewController(identifier: SearchViewController.identifier) as! SearchViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func listButtonClicked() {
        let vc = storyboard?.instantiateViewController(identifier: SearchViewController.identifier) as! SearchViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }

    override func configureView() {
        trendView.tableView.delegate = self
        trendView.tableView.dataSource = self
    }
    
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendList.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trendCell") as? TrendTableViewCell
        else {
            print("**CEll Error")
            return UITableViewCell()
        }
        
        let row = trendList.results[indexPath.item]
        let url = "https://www.themoviedb.org/t/p/original\(row.posterPath ?? "")"
        
        cell.mainImageView.kf.setImage(with: URL(string: url))
        cell.dateLabel.text = row.releaseDate
        cell.originalTitleLabel.text = row.originalTitle
        cell.titleLabel.text = row.title
        cell.rateNumberLabel.text = "\(row.voteAverage)"
        cell.castLabel.text = "castAPI 넣어야함"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let trendCell = tableView.cellForRow(at: indexPath) as? TrendTableViewCell,
              let creditViewController = storyboard?.instantiateViewController(withIdentifier: CreditViewController.identifier) as? CreditViewController else { return }
        let row = trendList.results[indexPath.item]
        
        creditViewController.selectedMovieID = row.id
        creditViewController.selectedMovieTitle = row.originalTitle
        creditViewController.selectedMovieBigImage = row.backdropPath
        creditViewController.selectedMoviePosterImage = row.posterPath
        creditViewController.selectedMovieOverviewContent = row.overview
        
        navigationController?.pushViewController(creditViewController, animated: true)
    }
    
    
}
