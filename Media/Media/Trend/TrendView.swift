//
//  TrendView.swift
//  Media
//
//  Created by 황예리 on 2023/08/28.
//

import UIKit

class TrendView: BaseView {
    
    lazy var tableView = {
        print("sksks")
        let view = UITableView()
        view.rowHeight = 400
        view.register(TrendTableViewCell.self, forCellReuseIdentifier: "TrendTableViewCell")
        return view
    }()
    
    override func configureView() {
        self.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}
