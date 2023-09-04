//
//  CreditViewController.swift
//  Media
//
//  Created by 황예리 on 2023/08/14.
//

import UIKit
import Kingfisher

class CreditViewController: BaseViewController {
    
    let mainView = CreditView()

    var creditList: Credit = Credit(id: 0, cast: [], crew: [])
    
    var selectedMovieData : Result?
    
    var isChevronButtonClicked = false
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "출연/제작"
        
        getData()
        
        mainView.chevronButton.addTarget(self, action: #selector(chevronButtonClicked), for: .touchUpInside)
    }
    
    @objc func chevronButtonClicked() {
        isChevronButtonClicked.toggle()
        mainView.contentLabel.numberOfLines = 0
    }
    
    override func configureView() {
        super.configureView()
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    func getData() {
        CreditAPIManager.shared.callRequest(movieID: selectedMovieData?.id ?? 0) { data in
            self.creditList = data
            print("*****list.data success", self.creditList)
            self.mainView.tableView.reloadData()
        } failure: {
            print(#function, "error")
        }
        
        let bigImageURL = "https://www.themoviedb.org/t/p/original\(selectedMovieData?.backdropPath ?? "")"
        let PosterImageURL = "https://www.themoviedb.org/t/p/original\(selectedMovieData?.posterPath ?? "")"
        
        mainView.bigImageView.kf.setImage(with: URL(string: bigImageURL))
        mainView.posterImageView.kf.setImage(with: URL(string: PosterImageURL))
        mainView.titleLabel.text = selectedMovieData?.originalTitle
        mainView.contentLabel.text = selectedMovieData?.overview
    }
    
    
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cast"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditList.cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreditTableViewCell") as? CreditTableViewCell else { return UITableViewCell() }
        
        let creditItem = creditList.cast[indexPath.item]
        let url = "https://www.themoviedb.org/t/p/original\(creditItem.profilePath ?? "")"
        
        cell.posterImageView.kf.setImage(with: URL(string: url))
        cell.castNameLabel.text = creditItem.name
        cell.subLabel.text = "\(creditItem.character ?? "") / \"No. \(creditItem.castID ?? 0)\""
        
        return cell
    }
    
}
