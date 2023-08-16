//
//  CreditViewController.swift
//  Media
//
//  Created by 황예리 on 2023/08/14.
//

import UIKit

class CreditViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bigImageView: UIImageView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var dividerView1: UIView!
    @IBOutlet var chevronButton: UIButton!
    @IBOutlet var dividerView2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        
        creditViewStyle()
        
        
    }
    
    func creditViewStyle() {
        bigImageView.contentMode = .scaleAspectFill
        posterImageView.contentMode = .scaleAspectFill
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        
        overviewLabel.text = "OverView"
        overviewLabel.font = .boldSystemFont(ofSize: 13)
        overviewLabel.textColor = .lightGray
        dividerView1.backgroundColor = .lightGray
        contentLabel.font = .systemFont(ofSize: 13)
        contentLabel.textColor = .black
        contentLabel.numberOfLines = 0
        chevronButton.setTitle("", for: .normal)
        chevronButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        dividerView2.backgroundColor = .lightGray
    }
    
    
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 //castDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CreditTableViewCell.identifier) as? CreditTableViewCell else { return CreditTableViewCell() }
        //let creditData = castDataList[indexPath.row]
        
//        cell.castNameLabel.text = creditData.character
//        cell.subLabel.text = creditData.name
        
        return cell
    }
    
}
