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
        view.register(CreditTableViewCell.self, forCellReuseIdentifier: "CreditTableViewCell")
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
        view.font = .boldSystemFont(ofSize: 18)
        view.textColor = .white
//        view.backgroundColor = .red
        return view
    }()
    
    let overviewLabel = {
        let view = UILabel()
        view.text = "OverView"
        view.font = .boldSystemFont(ofSize: 14)
        view.textColor = .lightGray
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
        view.textAlignment = .center
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
        
        topView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(350)
            make.bottom.equalTo(tableView.snp.top)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        bigImageView.snp.makeConstraints { make in
            make.top.equalTo(topView)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(topView).multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(topView).inset(20)
            make.top.equalTo(topView).offset(-15)
            make.height.equalTo(30)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.width.equalTo(bigImageView).multipliedBy(0.3)
            make.bottom.equalTo(bigImageView)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(bigImageView.snp.bottom).offset(30)
            make.trailing.equalTo(posterImageView.snp.trailing)
            make.height.equalTo(30)
        }
        
        dividerView1.snp.makeConstraints { make in
            make.leading.equalTo(overviewLabel)
            make.top.equalTo(overviewLabel.snp.bottom)
            make.bottom.equalTo(contentLabel.snp.top)
            make.height.equalTo(0.5)
            make.trailing.equalTo(bigImageView)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView1.snp.bottom)
            make.leading.equalTo(dividerView1).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.bottom.equalTo(chevronButton)
        }
        
        chevronButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(50)
        }
        
        dividerView2.snp.makeConstraints { make in
            make.top.equalTo(chevronButton.snp.bottom).offset(8)
            make.leading.equalTo(dividerView1)
            make.size.equalTo(dividerView1)
            make.bottom.equalTo(topView)
        }
        
        
    }
    
    
}
