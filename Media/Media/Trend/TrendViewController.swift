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
    
    let mainView = TrendView()
    
    var trendList: BoxOffice = BoxOffice(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TrendAPIManager.shared.callRequest { data in
            self.trendList = data
            //print("*****list.data success", self.trendList)
            self.mainView.tableView.reloadData()
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
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func listButtonClicked() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    override func configureView() {
        super.configureView()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func setConstraints() {
        super.setConstraints()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "trendCell") as! TrendTableViewCell
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
//        let cell = tableView.cellForRow(at: indexPath) as? TrendTableViewCell
        let vc = CreditViewController()
//        let row = trendList.results[indexPath.item]

//        creditViewController.selectedMovieID = row.id
//        creditViewController.selectedMovieTitle = row.originalTitle
//        creditViewController.selectedMovieBigImage = row.backdropPath
//        creditViewController.selectedMoviePosterImage = row.posterPath
//        creditViewController.selectedMovieOverviewContent = row.overview

        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
