//
//  ReusableViewProtocol.swift
//  SeSACWeek3
//
//  Created by 황예리 on 2023/08/11.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get } // 값을 가지고 오는 최소 요구사항만 충족해주기 위해서
}

extension UIViewController: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
    
}
