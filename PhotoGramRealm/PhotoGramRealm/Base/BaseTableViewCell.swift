//
//  BaseTableViewCell.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    @available(*, unavailable) // @available 특정 버전 이상 가능
    // 여기서는 해당구문 사용될 일이 없다! // unavailable 지정된 플랫폼에서 선언을 사용할 수 없음을 나타냄
    // 스토리보드에서 사용됨, 현재 스토리보드를 사용하지 않기때문에 다른 파일에서 required 안되게 하기위함
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {}
    
    func setConstraints() {}
}
