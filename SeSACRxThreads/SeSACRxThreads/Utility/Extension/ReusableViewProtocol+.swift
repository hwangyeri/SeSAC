//
//  ReusableViewProtocol+.swift
//  SeSACRxThreads
//
//  Created by Yeri Hwang on 2023/11/06.
//

import UIKit

protocol ReusableViewProtocol: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReusableViewProtocol where Self: NSObject {
    static var reuseIdentifier: String {
        return self.description()
    }
}

extension UIViewController: ReusableViewProtocol { }

extension UITableViewCell: ReusableViewProtocol { }
