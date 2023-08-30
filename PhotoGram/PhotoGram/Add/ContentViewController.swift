//
//  ContentViewControl.swift
//  PhotoGram
//
//  Created by 황예리 on 2023/08/29.
//

import UIKit

class ContentViewController: BaseViewController {

    let textView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var completionHandler: ((String) -> Void)?

    override func configureView() {
        super.configureView()
        
        view.addSubview(textView)
    }

    override func setConstraints() {
        
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(250)
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        completionHandler?(textView.text!) // 무슨 기능인지는 모르겠지만 매개변수를 들고 함수를 실행해
    }

}
