//
//  UIViewController+Extension.swift
//  SeSACFramework
//
//  Created by 황예리 on 2023/08/30.
//

import UIKit

extension UIViewController {
    
    public func sesacShowAlert(title: String, message: String, buttonTitle: String, buttonAction: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: buttonTitle, style: .default, handler: buttonAction)
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    public func sesacShowActivityViewController(image: UIImage, url: String, text: String) {
        let vc = UIActivityViewController(activityItems: [image, url, text], applicationActivities: nil)
        vc.excludedActivityTypes = [.mail] // 옵션을 안보이게 뺄 수 있음
        present(vc, animated: true)
    }
    
    
}

