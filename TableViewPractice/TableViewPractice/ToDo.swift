//
//  ToDo.swift
//  TableViewPractice
//
//  Created by 황예리 on 2023/07/28.
//

import Foundation
import UIKit // UIColor때문에 import했지만 원래 Model에는 Foundation만 import

struct ToDo { //식판
    var main: String
    var sub: String
    var like: Bool
    var done: Bool
    var color: UIColor // CGFloat #FFCDe2
}
