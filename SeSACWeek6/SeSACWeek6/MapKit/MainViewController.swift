//
//  MainViewController.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let mapButton = {
        let view = UIButton()
        view.setTitle("MapButton", for: .normal)
        view.tintColor = .black
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(mapButton)
        mapButton.backgroundColor = .systemMint
        mapButton.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.size.equalTo(100)
        }
        mapButton.addTarget(self, action: #selector(mapButtonClicked), for: .touchUpInside)
      
    }
    
    @objc func mapButtonClicked() {
        print(#function)
        let vc = TheaterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
}
