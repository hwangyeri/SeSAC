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
    
    var creditList: Movie = Movie(id: 0, cast: [], crew: [])
    
    var selectedMovieID: Int?
    var selectedMovieBigImage: String?
    var selectedMoviePosterImage: String?
    var selectedMovieTitle: String?
    var selectedMovieOverviewContent: String?
    var isChevronButtonClicked = false
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "출연/제작"
        
        CreditAPIManager.shared.callRequest(movieID: selectedMovieID ?? 0) { data in
            self.creditList = data
            print("*****list.data success", self.creditList)
            self.mainView.tableView.reloadData()
        } failure: {
            print(#function, "error")
        }
        
        let bigImageURL = "https://www.themoviedb.org/t/p/original\(selectedMovieBigImage ?? "")"
        let PosterImageURL = "https://www.themoviedb.org/t/p/original\(selectedMoviePosterImage ?? "")"
        mainView.bigImageView.kf.setImage(with: URL(string: bigImageURL))
        mainView.posterImageView.kf.setImage(with: URL(string: PosterImageURL))
        mainView.titleLabel.text = selectedMovieTitle
        mainView.contentLabel.text = selectedMovieOverviewContent
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cast"
    }
    
    @IBAction func chevronButtonClicked(_ sender: UIButton) {
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
    
    
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditList.cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "creditCell") as? CreditTableViewCell else { return CreditTableViewCell() }
        
        let creditItem = creditList.cast[indexPath.item]

        let url = "https://www.themoviedb.org/t/p/original\(creditItem.profilePath ?? "")"
        
        cell.posterImageView.kf.setImage(with: URL(string: url))
        cell.castNameLabel.text = creditItem.name
        cell.subLabel.text = "\(creditItem.character ?? "") / \"No. \(creditItem.castID ?? 0)\""
        
        return cell
    }
    
}
