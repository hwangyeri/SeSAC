//
//  CreditViewController.swift
//  Media
//
//  Created by 황예리 on 2023/08/14.
//

import UIKit
import Kingfisher

class CreditViewController: BaseViewController {
    
    let creditView = CreditView()
    
    var creditList: Movie = Movie(id: 0, cast: [], crew: [])
    
    var selectedMovieID: Int?
    var selectedMovieBigImage: String?
    var selectedMoviePosterImage: String?
    var selectedMovieTitle: String?
    var selectedMovieOverviewContent: String?
    var isChevronButtonClicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "출연/제작"
        
        CreditAPIManager.shared.callRequest(movieID: selectedMovieID ?? 0) { data in
            self.creditList = data
            print("*****list.data success", self.creditList)
            self.creditView.tableView.reloadData()
        } failure: {
            print(#function, "error")
        }
        
        let bigImageURL = "https://www.themoviedb.org/t/p/original\(selectedMovieBigImage ?? "")"
        let PosterImageURL = "https://www.themoviedb.org/t/p/original\(selectedMoviePosterImage ?? "")"
        creditView.bigImageView.kf.setImage(with: URL(string: bigImageURL))
        creditView.posterImageView.kf.setImage(with: URL(string: PosterImageURL))
        creditView.titleLabel.text = selectedMovieTitle
        creditView.contentLabel.text = selectedMovieOverviewContent
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cast"
    }
    
    @IBAction func chevronButtonClicked(_ sender: UIButton) {
        isChevronButtonClicked.toggle()
        creditView.contentLabel.numberOfLines = 0
    }
    
    override func configureView() {
        creditView.tableView.dataSource = self
        creditView.tableView.delegate = self
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
