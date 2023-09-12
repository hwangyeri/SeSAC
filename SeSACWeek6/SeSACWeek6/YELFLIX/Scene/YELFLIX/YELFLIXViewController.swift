//
//  YELFLIXViewController.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/25.
//

import UIKit
import SnapKit

class YELFLIXViewController: UIViewController {
    
    let backImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "background")
        view.backgroundColor = .black
        view.alpha = 0.4
        return view
    }()
    
    let mainImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "어벤져스엔드게임")
        view.backgroundColor = .systemGray
        return view
    }()
    
    let nLabel = {
        let view = UILabel()
        view.font = UIFont(name: "OTSBAggroB", size: 45)
        view.text = "N"
        view.textColor = .white
        return view
    }()
    
    let tvTopButton = {
        let view = TopButton()
        view.setTitle("TV 프로그램", for: .normal)
        return view
    }()
    
    let movieTopButton = {
        let view = TopButton()
        view.setTitle("영화", for: .normal)
        return view
    }()
    
    let myPickTopButton = {
        let view = TopButton()
        view.setTitle("내가 찜한 콘텐츠", for: .normal)
        return view
    }()
    
    let previewLabel = {
        let view = UILabel()
        view.text = "미리보기"
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 16)
        return view
    }()
    
    let myPickButton = {
        let view = BottomButton()
        view.setTitle("내가 찜한 콘텐츠", for: .normal)
        view.setImage(UIImage(named: "check"), for: .normal)
        return view
    }()
    
    let playButton = {
        let view = BottomButton()
        view.setImage(UIImage(named: "play_normal"), for: .normal)
        return view
    }()
    
    let InformationButton = {
        let view = BottomButton()
        view.setTitle("정보", for: .normal)
        view.setImage(UIImage(named: "info"), for: .normal)
        return view
    }()
    
    let firstPreviewImageView = {
        let view = CircleImageView(frame: .zero)
        view.image = UIImage(named: "1")
        return view
    }()
    
    let secondPreviewImageView = {
        let view = CircleImageView(frame: .zero)
        view.image = UIImage(named: "2")
        return view
    }()
    
    let thirdPreviewImageView = {
        let view = CircleImageView(frame: .zero)
        view.image = UIImage(named: "3")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let subviews: [UIView] = [
            mainImageView, backImageView, nLabel, tvTopButton, movieTopButton, myPickTopButton, myPickButton, playButton, InformationButton, previewLabel, firstPreviewImageView, secondPreviewImageView, thirdPreviewImageView
        ]
        
        subviews.forEach { subview in
            view.addSubview(subview)
        }
        
        setupConstraints()
    }
    

    func setupConstraints() {
        
        backImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.8)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.8)
        }
        
        nLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(10)
        }
        
        tvTopButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(85)
        }
        
        movieTopButton.snp.makeConstraints { make in
            make.top.equalTo(tvTopButton)
            make.leading.equalTo(tvTopButton.snp_trailingMargin).offset(30)
        }
        
        myPickTopButton.snp.makeConstraints { make in
            make.top.equalTo(tvTopButton)
            make.leading.equalTo(movieTopButton.snp_trailingMargin).offset(30)
        }
        
        myPickButton.snp.makeConstraints { make in
            make.bottom.equalTo(mainImageView.snp.bottom).inset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        playButton.snp.makeConstraints { make in
            make.top.equalTo(myPickButton).offset(10)
            make.centerX.equalToSuperview().offset(10)
        }
        
        InformationButton.snp.makeConstraints { make in
            make.top.equalTo(myPickButton)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        previewLabel.snp.makeConstraints { make in
            make.leading.equalTo(view)
            make.top.equalTo(mainImageView.snp_bottomMargin).offset(10)
        }
        
        firstPreviewImageView.snp.makeConstraints { make in
            make.leading.equalTo(previewLabel)
            make.top.equalTo(previewLabel.snp.bottom).offset(10)
            make.size.equalTo(120)
        }
        
        secondPreviewImageView.snp.makeConstraints { make in
            make.leading.equalTo(firstPreviewImageView.snp.trailing).offset(10)
            make.top.size.equalTo(firstPreviewImageView)
        }
        
        thirdPreviewImageView.snp.makeConstraints { make in
            make.leading.equalTo(secondPreviewImageView.snp.trailing).offset(10)
            make.top.size.equalTo(firstPreviewImageView)
        }
    }
    
    
}
