//
//  showAlertMessage+Extension.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/09/06.
//

import UIKit

extension UIViewController {
    
    func showAlertMessage(title: String, button: String = "확인", handler: (() -> ())? = nil ) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .default) { _ in
            handler?()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}
