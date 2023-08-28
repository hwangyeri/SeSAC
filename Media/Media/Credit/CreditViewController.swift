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
    
//    @IBOutlet var creditTableView: UITableView!
//    @IBOutlet var bigImageView: UIImageView!
//    @IBOutlet var posterImageView: UIImageView!
//    @IBOutlet var titleLabel: UILabel!
//    @IBOutlet var overviewLabel: UILabel!
//    @IBOutlet var contentLabel: UILabel!
//    @IBOutlet var dividerView1: UIView!
//    @IBOutlet var chevronButton: UIButton!
//    @IBOutlet var dividerView2: UIView!
    
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
        
//        creditTableView.dataSource = self
//        creditTableView.delegate = self
//        creditTableView.rowHeight = 120
//        creditViewStyle()
        
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
    
//    func creditViewStyle() {
//        bigImageView.contentMode = .scaleAspectFill
//        posterImageView.contentMode = .scaleAspectFill
//        titleLabel.font = .boldSystemFont(ofSize: 20)
//        titleLabel.textColor = .white
//
//        overviewLabel.text = "OverView"
//        overviewLabel.font = .boldSystemFont(ofSize: 14)
//        overviewLabel.textColor = .darkGray
//        dividerView1.backgroundColor = .lightGray
//        contentLabel.font = .systemFont(ofSize: 13)
//        contentLabel.textColor = .black
//        contentLabel.numberOfLines = 3
//        chevronButton.setTitle("", for: .normal)
//        chevronButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
//        chevronButton.tintColor = .black
//        dividerView2.backgroundColor = .lightGray
//    }
    
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
