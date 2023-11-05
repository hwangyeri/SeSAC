//
//  ShoppingListTableViewCell.swift
//  Setting
//
//  Created by Yeri Hwang on 2023/11/05.
//

import UIKit
import SnapKit
import RxSwift

final class ShoppingListTableViewCell: UITableViewCell {
    
    static let identifier = "ShoppingListTableViewCell"
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    let checkboxButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let starButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.setImage(UIImage(systemName: "star.fill"), for: .selected)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.layer.cornerRadius = 25
        self.backgroundColor = .systemGray6
        configureLayout()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        [checkboxButton, contentLabel, starButton].forEach {
            contentView.addSubview($0)
        }
        
        checkboxButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(40)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(checkboxButton.snp.trailing)
        }
        
        starButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(40)
        }
    }

}
