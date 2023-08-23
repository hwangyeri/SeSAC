//
//  SnapViewController.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/22.
//

import UIKit
import SnapKit

/*
 addSubview
 superview
 offset 한 방향으로 밀어주는 것
 inset 안쪽으로 들어오는 것
 RTL Right to Left
 */

class SnapViewController: UIViewController {
    
    let redView = UIView()
    let whiteView = UIView()
    let blueView = UIView()
    let yellowView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

        view.addSubview(redView) // addSubview한 순서대로 추가됨
        redView.backgroundColor = .systemRed
        redView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(150)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(whiteView)
        whiteView.backgroundColor = .white
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide) // == make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        view.addSubview(blueView)
        blueView.backgroundColor = .systemBlue
        blueView.snp.makeConstraints { make in
            make.center.equalTo(view) // ==  make.centerX.centerY.equalTo(view)
            make.size.equalTo(200) // == make.width.height.equalTo(200)
        }
        
        blueView.addSubview(yellowView)
        yellowView.backgroundColor = .systemYellow
        yellowView.snp.makeConstraints { make in
//            make.size.equalTo(150)
//            make.leading.top.equalToSuperview()
            
            make.edges.equalTo(blueView).inset(50) // == make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        
    }
    

    

}
