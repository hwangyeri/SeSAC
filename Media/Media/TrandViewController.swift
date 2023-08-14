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

class TrandViewController: UIViewController {
    
    @IBOutlet var trandTableView: UITableView!
    
    var trandDataList: [Trand] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trandTableView.delegate = self
        trandTableView.dataSource = self
        //        tableView.rowHeight = UIScreen.main.bounds.height
        
        TrandAPIManager.shared.callRequest() { result in
            self.trandDataList.append(result)
            self.trandTableView.reloadData()
        }
    }
    
    
}

extension TrandViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trandDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrandTableViewCell.identifier) as? TrandTableViewCell else { return TrandTableViewCell() }
        let trandData = trandDataList[indexPath.row]
        
        TrandAPIManager.shared.callRequest() { _ in
            
            if let imageURL = URL(string: "https://image.tmdb.org/t/p\(trandData.trandPosterURL)") {
                cell.mainImageView.kf.setImage(with: imageURL)
            }
            
            if let genre = trandData.trandGenre.first {
                cell.dateLabel.text = trandData.trandDate
                cell.genreLabel.text = "\(genre)"
                
                cell.rateNumberLabel.text = "\(trandData.trandRate)"
                cell.titleLabel.text = trandData.trandTitle
            }
        }
        
        return cell
    }
    
    
}
