//
//  CustomTableViewCell.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/25.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    let label = UILabel()
    let button = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setConstraints() // addSubView 이후에 constraints 설정
    }
    
    required init?(coder: NSCoder) { // 코드베이스여도 결국 스토리보드 안쓴다고 명시적으로 얘기해야함
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() { // 정적인 디자인
        //addSubview(label) // 오류가 안남...하지만 레이아웃 안 잡힘
        contentView.addSubview(label) // TableViewCell UIView name -> Content View
        contentView.addSubview(button)
        label.backgroundColor = .yellow
        button.backgroundColor = .green
    }
    
    func setConstraints() { // 제약조건
        
        button.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.trailingMargin.equalTo(contentView) // 수직 중앙
        }
        
        label.snp.makeConstraints { make in
            make.top.leadingMargin.bottom.equalTo(contentView)
            make.trailing.equalTo(button.snp.leading).inset(8)
        }
    }
    
    //Interface Builder
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
