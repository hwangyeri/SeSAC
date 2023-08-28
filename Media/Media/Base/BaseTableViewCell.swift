//
//  BaseTableViewCell.swift
//  Media
//
//  Created by 황예리 on 2023/08/28.
//

import UIKit
import SnapKit

class BaseTableViewCell: UITableViewCell {
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() { //addSubview
        
    }
    
    func setConstraints() { // 제약조건
        
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
