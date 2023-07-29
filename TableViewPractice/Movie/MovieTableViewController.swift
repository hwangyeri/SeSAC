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
        
        cell.mainLable.font = .boldSystemFont(ofSize: 18)
        cell.mainLable.numberOfLines = 1
        cell.subLable.font = .systemFont(ofSize: 15)
        cell.subLable.numberOfLines = 1
        cell.overviewLable.font = .systemFont(ofSize: 13)
        cell.overviewLable.numberOfLines = 5
        
        cell.posterImageView.image = UIImage(named: movieInfo.movie[indexPath.row].imageName)
        cell.mainLable.text = "\(movieInfo.movie[indexPath.row].title)"
        cell.subLable.text = "\(movieInfo.movie[indexPath.row].releaseDate) | \(movieInfo.movie[indexPath.row].runtime)분 | \(movieInfo.movie[indexPath.row].rate)점"
        cell.overviewLable.text = "\(movieInfo.movie[indexPath.row].overview)"
        
        
        return cell
    }




}
