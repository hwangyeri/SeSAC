//
//  SimpleTableViewController.swift
//  SeSACRxThreads
//
//  Created by Yeri Hwang on 2023/11/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SimpleTableViewController: ViewController {
    
    let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = Color.black
        label.text = "result"
        label.textAlignment = .center
         return label
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        setTableView()
    }
    
    func setTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let item = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])
        
        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )
        
        items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "@ \(row), @ \(element)"
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .map { data in
                "\(data) 를 클릭했어요."
            }
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .subscribe { value in
                DefaultWireframe.presentAlert("")
            }
            .disposed(by: disposeBag)
    }
    
    func configureLayout() {
        view.addSubview(tableView)
        view.addSubview(resultLabel)
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
