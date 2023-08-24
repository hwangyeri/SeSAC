//
//  YELFLIXViewController.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/25.
//

import UIKit
import SnapKit

class YELFLIXViewController: UIViewController {
    
    let mainImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .systemGray
        return view
    }()
    
    let nImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .white
        return view
    }()
    
    let tvButton = {
        let view = topButton()
        view.setTitle("TV 프로그램", for: .normal)
        return view
    }()
    
    let movieButton = {
        let view = topButton()
        view.setTitle("영화", for: .normal)
        return view
    }()
    
    let myPickButton = {
        let view = topButton()
        view.setTitle("내가 찜한 콘텐츠", for: .normal)
        return view
    }()
    
    let previewLabel = {
        let view = UILabel()
        view.text = "미리보기"
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 17)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let subviews: [UIView] = [
            mainImageView, nImageView, tvButton, movieButton, myPickButton, previewLabel
        ]
        
        subviews.forEach { subview in
            view.addSubview(subview)
        }
        
        setupConstraints()
    }
    

    func setupConstraints() {
        
        mainImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.8)
        }
        
        nImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(50)
        }
        
        tvButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(85)
        }
        
        movieButton.snp.makeConstraints { make in
            make.top.equalTo(tvButton)
            make.leading.equalTo(tvButton.snp_trailingMargin).offset(30)
        }
        
        myPickButton.snp.makeConstraints { make in
            make.top.equalTo(tvButton)
            make.leading.equalTo(movieButton.snp_trailingMargin).offset(30)
        }
        
        previewLabel.snp.makeConstraints { make in
            make.leading.equalTo(nImageView)
            make.top.equalTo(mainImageView.snp_bottomMargin).offset(30)
        }
        
        
    }
    
    
}
