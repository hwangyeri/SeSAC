//
//  Extension.swift
//  TableViewPractice
//
//  Created by 황예리 on 2023/07/27.
//

import Foundation
import UIKit

extension UITableViewController {
    func showAlert() {
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "ok", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension UILabel {
    
    func configureTitleText() {
        self.textColor = .red
        self.font = .boldSystemFont(ofSize: 20)
        self.textAlignment = .center
    }
    
}
