//
//  ShoppingListView.swift
//  Setting
//
//  Created by Yeri Hwang on 2023/11/16.
//

import UIKit
import SnapKit

class ShoppingListView: UIView {
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 20
        return view
    }()
    
    let textField: UITextField = {
       let view = UITextField()
        view.placeholder = "무엇을 구매하실 건가요?"
        return view
    }()
    
    let addButton: UIButton = {
        let view = UIButton()
        view.setTitle("추가", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemGray5
        return view
    }()
    
    let tableView: UITableView = {
       let view = UITableView()
        view.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.identifier)
        view.rowHeight = 65
        view.separatorStyle = .singleLine
       return view
     }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        [backView, tableView].forEach {
            self.addSubview($0)
        }
        
        [textField, addButton].forEach {
            backView.addSubview($0)
        }
    }
    
    func setConstraints() {
        backView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(66)
        }
        
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        addButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(textField.snp.trailing)
            make.trailing.equalToSuperview().inset(15)
            make.width.equalTo(70)
            make.height.equalTo(38)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
}
