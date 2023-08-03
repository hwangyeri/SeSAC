//
//  LookAroundViewController.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/08/02.
//

import UIKit

class LookAroundViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    var movieInfo = MovieInfo()
    
    @IBOutlet var recentCollectionView: UICollectionView!
    @IBOutlet var bestTableView: UITableView!
    @IBOutlet var recentLable: UILabel!
    @IBOutlet var bestLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 부하직원 연결
        recentCollectionView.delegate = self
        recentCollectionView.dataSource = self
        bestTableView.dataSource = self
        bestTableView.delegate = self
        
        //XIB
        let nib1 = UINib(nibName: RecentCollectionViewCell.identifier, bundle: nil)
        let nib2 = UINib(nibName: BestTableViewCell.identifier, bundle: nil)
        recentCollectionView.register(nib1, forCellWithReuseIdentifier: RecentCollectionViewCell.identifier)
        bestTableView.register(nib2, forCellReuseIdentifier: BestTableViewCell.identifier)
        
        configureRecentCollectionViewLayout()
        
        lableStyle(lable: recentLable, title: "최근 본 작품")
        lableStyle(lable: bestLable, title: "요즘 인기 작품")
    }
    
    func lableStyle(lable: UILabel, title: String) {
        lable.text = title
        lable.font = .monospacedDigitSystemFont(ofSize: 15, weight: .black)
        lable.textColor = .black
    }
    
    // MARK: - collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCollectionViewCell.identifier, for: indexPath) as! RecentCollectionViewCell
        let row = movieInfo.movie[indexPath.row]
        cell.configureCell(row: row)
        
        return cell
    }
    
    func configureRecentCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 0
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width / 5, height: width / 3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = spacing
        
        recentCollectionView.collectionViewLayout = layout
        recentCollectionView.isPrefetchingEnabled = true
    }
    
    //MARK: - tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BestTableViewCell.identifier) as! BestTableViewCell
        let row = movieInfo.movie[indexPath.row]
        cell.configureCell(row: row)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        return cell
    }


}
