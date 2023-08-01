//
//  MovieTableViewController.swift
//  TableViewPractice
//
//  Created by 황예리 on 2023/07/28.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    let movieInfo = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.rowHeight = 150
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as! MovieTableViewCell
        let row = movieInfo.movie[indexPath.row]
        
        cell.mainLable.font = .boldSystemFont(ofSize: 18)
        cell.mainLable.numberOfLines = 1
        cell.subLable.font = .systemFont(ofSize: 15)
        cell.subLable.numberOfLines = 1
        cell.overviewLable.font = .systemFont(ofSize: 13)
        cell.overviewLable.numberOfLines = 5
        
        cell.posterImageView.image = UIImage(named: row.imageName)
        cell.mainLable.text = "\(row.title)"
        cell.subLable.text = row.subLableTitle
        cell.overviewLable.text = "\(row.overview)"
        
        
        return cell
    }




}
