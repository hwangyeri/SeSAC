//
//  CreditView.swift
//  Media
//
//  Created by 황예리 on 2023/08/28.
//

import UIKit

class CreditView: BaseView {
    
    lazy var tableView = {
        let view = UITableView()
        view.rowHeight = 120
        view.register(CreditTableViewCell.self, forCellReuseIdentifier: "creditCell")
        return view
    }()
    
    let topView = {
        let view = UIView()
        return view
    }()
    
    let bigImageView = {
        let view = CreditImageView(frame: .zero)
        return view
    }()
    
    let posterImageView = {
        let view = CreditImageView(frame: .zero)
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .white
        return view
    }()
    
    let overviewLabel = {
        let view = UILabel()
        view.text = "OverView"
        view.font = .boldSystemFont(ofSize: 14)
        view.textColor = .darkGray
        return view
    }()
    
    let dividerView1 = {
        let view = DividerView()
        return view
    }()
    
    let contentLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        view.textColor = .black
        view.numberOfLines = 3
        return view
    }()
    
    let chevronButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        view.tintColor = .black
        return view
    }()
    
    let dividerView2 = {
        let view = DividerView()
        return view
    }()
    
    override func configureView() {
        [tableView, topView, bigImageView, posterImageView, titleLabel, overviewLabel, dividerView1, contentLabel, chevronButton, dividerView2].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topView.snp.makeConstraints { make in
            make.edges.equalTo(UIScreen.main.bounds.size).multipliedBy(0.5)
        }
        
        bigImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(topView).multipliedBy(0.45)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(bigImageView.snp.bottom).offset(10)
        }
        
        dividerView1.snp.makeConstraints { make in
            make.leading.equalTo(overviewLabel)
            make.top.equalTo(overviewLabel.snp.bottom).offset(8)
            make.height.equalTo(1)
            make.trailing.equalTo(bigImageView)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView1.snp.bottom).offset(10)
            make.leading.equalTo(dividerView1).offset(10)
        }
        
        chevronButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(50)
        }
        
        dividerView2.snp.makeConstraints { make in
            make.top.equalTo(chevronButton.snp.bottom).offset(8)
            make.size.equalTo(dividerView1)
        }
        
        
    }
    
    
}
