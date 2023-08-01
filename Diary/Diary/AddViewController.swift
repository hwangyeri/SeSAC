//
//  AddViewController.swift
//  Diary
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit

class AddViewController: UIViewController {
    
    static let identifier = "AddViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        
        title = "추가 화면" // navigation title
       
        //LeftBarButton
        let xmark = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        
        navigationItem.leftBarButtonItem?.tintColor = .red
    }
    
    @objc
    func closeButtonClicked() {
        
        //Present - Dismiss
        dismiss(animated: true)
        
        //Push - pop, 짝꿍을 잘 맞춰야함
        //navigationController?.popViewController(animated: true)
    }
    
    

}
