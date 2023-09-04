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
    
    var trendList: Trend = Trend(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData(selectedListItem: .all)
        configureNaviBarButtonItem()
        
    }
    
    override func configureView() {
        super.configureView()
        //print(#function, "---------")
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    @objc func searchButtonClicked() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func listButtonClicked() {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actionTV = UIAlertAction(title: "TV", style: .default) { _ in
            self.getData(selectedListItem: .tv)
        }
        let actionMovie = UIAlertAction(title: "Movie", style: .default) { _ in
            self.getData(selectedListItem: .movie)
        }
        let actionPerson = UIAlertAction(title: "Person", style: .default) { _ in
            //FIXME: DecodingError
            self.getData(selectedListItem: .person)
        }
        let actionShowAll = UIAlertAction(title: "All", style: .default) { _ in
            self.getData(selectedListItem: .all)
        }
        let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheetController.addAction(actionTV)
        actionSheetController.addAction(actionMovie)
        actionSheetController.addAction(actionPerson)
        actionSheetController.addAction(actionShowAll)
        actionSheetController.addAction(actionCancel)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func getData(selectedListItem: Endpoint) {
        print(#function, "---- 데이터 받아오기 ----")
        
        TrendAPIManager.shared.callRequest(type: selectedListItem) { data in
            self.trendList = data
            print("*****list.data success", self.trendList)
            self.mainView.tableView.reloadData()
        } failure: {
            print(#function, "error")
        }
    }
    
    func configureNaviBarButtonItem() {
        let listButtonIcon = UIImage(systemName: "list.triangle")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: listButtonIcon, style: .plain, target: self, action: #selector(listButtonClicked))
        
        let searchButtonIcon = UIImage(systemName: "magnifyingglass")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: searchButtonIcon, style: .plain, target: self, action: #selector(searchButtonClicked))
    }
    
    
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return trendList.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrendTableViewCell") as? TrendTableViewCell else { return UITableViewCell() }
        let row = trendList.results[indexPath.item]
        let url = "https://www.themoviedb.org/t/p/original\(row.backdropPath ?? "")"
        let genre = row.genreIDS.first ?? 0
        
        cell.mainImageView.kf.setImage(with: URL(string: url))
        cell.dateLabel.text = row.releaseDate
        cell.originalTitleLabel.text = row.originalTitle
        cell.titleLabel.text = row.title ?? row.name
        cell.rateNumberLabel.text = "\(row.voteAverage)"
        cell.castLabel.text = "castAPI 넣어야함"
        
        if let genreID = row.genreIDS.first, let genre = Genre(rawValue: genreID) {
            cell.genreLabel.text = "#\(genre.description)"
        } else {
            cell.genreLabel.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CreditViewController()
        let data = trendList.results[indexPath.item]
        
        vc.selectedMovieData = data
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
