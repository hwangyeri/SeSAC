//
//  BeerViewController.swift
//  SeSACWeek3
//
//  Created by 황예리 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct Beer {
    var beerImageURL: String
    var beerName: String
    var beerDescription: String
}

class BeerViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var beerList: [Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UIScreen.main.bounds.height
    }
    
    
    func callRequest() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                if let beerData = json.arrayValue.first {
                    let beerImageURL = beerData["image_url"].stringValue
                    let beerName = beerData["name"].stringValue
                    let beerDescription = beerData["description"].stringValue
                    
                    let data = Beer(beerImageURL: beerImageURL, beerName: beerName, beerDescription: beerDescription)
                    self.beerList.removeAll()
                    self.beerList.append(data)
                    self.tableView.reloadData()
                    
                    print(beerName, beerDescription)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        callRequest()
    }
    
    
}

extension BeerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier) as! BeerTableViewCell
        let beerData = beerList[indexPath.row]
        
        cell.beerNameLabel.text = beerData.beerName
        cell.beerInfoLabel.text = beerData.beerDescription
        
        if let imageURL = URL(string: beerData.beerImageURL) {
            cell.beerImageView.kf.setImage(with: imageURL)
        }
        
        return cell
    }
    
    
}
