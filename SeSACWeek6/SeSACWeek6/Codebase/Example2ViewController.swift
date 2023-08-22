//
//  Example2ViewController.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/22.
//

import UIKit
import SnapKit

class Example2ViewController: UIViewController {
    
    let backImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let cancelButton = {
        let view = UIButton()
        view.tintColor = .white
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let settingButton = {
        let view = UIButton()
        view.tintColor = .white
        view.setImage(UIImage(systemName: "gearshape.circle"), for: .normal)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let giftsButton = {
        let view = UIButton()
        view.tintColor = .white
        view.setImage(UIImage(systemName: "gift.circle"), for: .normal)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let profileImageView = {
        let view = UIImageView()
        view.backgroundColor = .darkGray
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 25
        return view
    }()
    
    let nicknameLabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 15)
        view.textAlignment = .center
        view.numberOfLines = 1
        view.text = "Yeri"
        return view
    }()
    
    let statusMessageLabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 15)
        view.textAlignment = .center
        view.numberOfLines = 1
        view.text = "상태 메세지"
        return view
    }()
    
    let dividerView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let myChatButton = {
        let view = UIButton()
        view.tintColor = .white
        view.setTitle("나와의 채팅", for: .normal)
        view.setImage(UIImage(systemName: "message.fill"), for: .normal)
        return view
    }()
    
    let profileEditButton = {
        let view = UIButton()
        view.tintColor = .white
        view.setTitle("프로필 편집", for: .normal)
        view.setImage(UIImage(systemName: "pencil"), for: .normal)
        return view
    }()
    
    let kakaoStoryButton = {
        let view = UIButton()
        view.tintColor = .white
        view.setTitle("카카오스토리", for: .normal)
        view.setImage(UIImage(systemName: "quote.bubble.fill"), for: .normal)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let subviews: [UIView] = [
            backImageView, cancelButton, settingButton, giftsButton,
            profileImageView, nicknameLabel, statusMessageLabel, dividerView,
            myChatButton, profileEditButton, kakaoStoryButton
        ]
        
        subviews.forEach { subview in
            view.addSubview(subview)
        }
        
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        
        backImageView.snp.makeConstraints { make in
            make.size.equalTo(view)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.size.equalTo(30)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(cancelButton)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(giftsButton).offset(25)
            make.size.equalTo(cancelButton)
        }
        
        giftsButton.snp.makeConstraints { make in
            make.top.equalTo(cancelButton)
            make.size.equalTo(cancelButton)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.size.equalTo(90)
            make.bottom.equalTo(view).inset(200)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(profileImageView).offset(30)
        }
        
        statusMessageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(nicknameLabel).offset(30)
        }
        
        dividerView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(statusMessageLabel).offset(20)
            make.height.equalTo(0.5)
            make.width.equalTo(view)
        }
        
        myChatButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(30)
        }
        
        profileEditButton.snp.makeConstraints { make in
            make.top.equalTo(myChatButton)
            make.height.equalTo(myChatButton)
            make.centerX.equalTo(view)
        }
        
        kakaoStoryButton.snp.makeConstraints { make in
            make.top.equalTo(myChatButton)
            make.height.equalTo(myChatButton)
            make.trailing.equalTo(view.safeAreaInsets).inset(30)
        }
        
    }
    

}
