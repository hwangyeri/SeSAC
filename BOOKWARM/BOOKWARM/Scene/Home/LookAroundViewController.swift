//
//  LookAroundViewController.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/08/02.
//

import UIKit
import RealmSwift

class LookAroundViewController: UIViewController {
    
//    var movieInfo = MovieInfo()
    
    @IBOutlet var recentCollectionView: UICollectionView!
    @IBOutlet var bestTableView: UITableView!
    @IBOutlet var recentLable: UILabel!
    @IBOutlet var bestLable: UILabel!
    
    var tasks: Results<BookTable>!
    let realm = try! Realm()
    
    var book: Book = Book(documents: [], meta: Meta(isEnd: false))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 부하직원 연결
        recentCollectionView.delegate = self
        recentCollectionView.dataSource = self
        bestTableView.dataSource = self
        bestTableView.delegate = self
        bestTableView.rowHeight = 120
        
        //XIB
        let nib1 = UINib(nibName: RecentCollectionViewCell.reuseIdentifier, bundle: nil)
        let nib2 = UINib(nibName: BestTableViewCell.reuseIdentifier, bundle: nil)
        recentCollectionView.register(nib1, forCellWithReuseIdentifier: RecentCollectionViewCell.reuseIdentifier)
        bestTableView.register(nib2, forCellReuseIdentifier: BestTableViewCell.reuseIdentifier)
        
        configureRecentCollectionViewLayout()
        
        lableStyle(lable: recentLable, title: "최근 본 작품")
        lableStyle(lable: bestLable, title: "요즘 인기 작품")
    }
    
    func lableStyle(lable: UILabel, title: String) {
        lable.text = title
        lable.font = .monospacedDigitSystemFont(ofSize: 15, weight: .black)
        lable.textColor = .black
    }

}

extension LookAroundViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return book.documents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCollectionViewCell.reuseIdentifier, for: indexPath) as! RecentCollectionViewCell
        let row = tasks[indexPath.row]
//        cell.configureCell(row: row)
        
        return cell
    }
    
    func configureRecentCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 0
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width / 4, height: width / 3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = spacing
        
        recentCollectionView.collectionViewLayout = layout
        recentCollectionView.isPrefetchingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: DetailViewController.reuseIdentifier) as! DetailViewController
//        let selectedMovie = movieInfo.movie[indexPath.row]
//
//        vc.selectedMovie = selectedMovie
//        vc.naviTitle = movieInfo.movie[indexPath.row].title
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LookAroundViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BestTableViewCell.reuseIdentifier) as! BestTableViewCell
        let row = tasks[indexPath.row]
        cell.configureCell(row: row)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: DetailViewController.reuseIdentifier) as! DetailViewController
//        let selectedMovie = movieInfo.movie[indexPath.row]
//
//        vc.selectedMovie = selectedMovie
//        vc.naviTitle = movieInfo.movie[indexPath.row].title
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
