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

class TrendViewController: UIViewController {
    
    @IBOutlet var trendTableView: UITableView!
    
    var trendList: BoxOffice = BoxOffice(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendTableView.delegate = self
        trendTableView.dataSource = self
        trendTableView.rowHeight = 500//UITableView.automaticDimension
        
        TrendAPIManager.shared.callRequest { data in
            self.trendList = data
            //print("*****list.data success", self.trendList)
            self.trendTableView.reloadData()
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

    
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendList.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TrendTableViewCell.identifier
            ) as? TrendTableViewCell
        else {
            print("**CEll Error")
            return UITableViewCell()
        }
        
        let item = trendList.results[indexPath.item]
        let url = "https://www.themoviedb.org/t/p/original\(item.posterPath ?? "")"
        
        cell.mainImageView.kf.setImage(with: URL(string: url))
        cell.dateLabel.text = item.releaseDate
        cell.originalTitleLabel.text = item.originalTitle
        cell.titleLabel.text = item.title
        cell.rateNumberLabel.text = "\(item.voteAverage)"
        cell.castLabel.text = "castAPI 넣어야함"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let trendCell = tableView.cellForRow(at: indexPath) as? TrendTableViewCell,
              let creditViewController = storyboard?.instantiateViewController(withIdentifier: CreditViewController.identifier) as? CreditViewController else { return }
        let item = trendList.results[indexPath.item]
        
        creditViewController.selectedMovieID = item.id
        creditViewController.selectedMovieTitle = item.originalTitle
        creditViewController.selectedMovieBigImage = item.backdropPath
        creditViewController.selectedMoviePosterImage = item.posterPath
        creditViewController.selectedMovieOverviewContent = item.overview
        
        navigationController?.pushViewController(creditViewController, animated: true)
    }
    
    
    
    
}
