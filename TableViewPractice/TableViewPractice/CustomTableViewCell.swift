//
//  CustomTableViewCell.swift
//  TableViewPractice
//
//  Created by 황예리 on 2023/07/28.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"

    @IBOutlet var backView: UIView!
    @IBOutlet var checkboxImage: UIImageView!
    @IBOutlet var starButton: UIButton!
    @IBOutlet var mainTitleLable: UILabel!
    @IBOutlet var subTitleLable: UILabel!
    
    /*
     1. TableViewController Scene & Logic File
     2. TableViewCell Logic -> 매칭 -> 아웃렛
        - identifier 동일한 이름으로 매칭하기
        - Content View/UIView 연결 X
     3. TVC class 연결 -> TVC
     4.
     5.
     6. Cell 연결 -> identifier 아웃렛 액션
     */
    
    override func awakeFromNib() { // 인스턴스 메서드
        // 매번 reload가 필요없는 정적인 디자인
        super.awakeFromNib()
        
        mainTitleLable.font = .boldSystemFont(ofSize: 17)
        mainTitleLable.textColor = .brown
        
    }
    
//    //static func -> override class
//    override class func awakeFromNib() { // 타입 메서드
//        <#code#>
//    }
    
    func configureCell(row: ToDo) {
        
        backView.backgroundColor = row.color
        
        mainTitleLable.text = row.main
        subTitleLable.text = row.sub
        
        if row.done {
            checkboxImage.image = UIImage(systemName: "checkmark.square.fill")
        } else {
            checkboxImage.image = UIImage(systemName: "checkmark.square")

        }
        
        if row.like {
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            starButton.setImage(UIImage(systemName: "star"), for: .normal)

        }
        
    }
    
    
    
}
