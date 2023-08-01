//
//  DiaryTableViewCell.swift
//  Diary
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {
    
    static let identifier = "DiaryTableViewCell" // 타입 프로퍼티

    @IBOutlet var contentLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
