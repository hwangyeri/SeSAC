//
//  SimpleTableViewController.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/14.
//

import UIKit

class SimpleTableViewController: UITableViewController {
    
    var list = [User(name: "Hue", age: 23), User(name: "Jack", age: 21), User(name: "Bran", age: 20), User(name: "KoKojong", age: 20)]


    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = list[indexPath.row].name
        content.secondaryText = "\(list[indexPath.row].age)"
        cell.contentConfiguration = content
        return cell
    }

    
}
