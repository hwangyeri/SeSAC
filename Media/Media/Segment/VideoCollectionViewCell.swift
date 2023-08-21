//
//  VideoCollectionViewCell.swift
//  Media
//
//  Created by 황예리 on 2023/08/21.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var temp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func configureVideoCell(with data: videoResult) {
        temp.text = data.name
        print(temp.text, "**** Video temp text")
    }

}
