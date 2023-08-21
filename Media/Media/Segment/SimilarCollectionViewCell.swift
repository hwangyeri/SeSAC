//
//  SimilarCollectionViewCell.swift
//  Media
//
//  Created by 황예리 on 2023/08/21.
//

import UIKit

class SimilarCollectionViewCell: UICollectionViewCell {

    @IBOutlet var temp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    func configureSimilarCell(with data: similarResult) {
        temp.text = data.title
        print(temp.text, "**** Similar temp text")
    }

}
