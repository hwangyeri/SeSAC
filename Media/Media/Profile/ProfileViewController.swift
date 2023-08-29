//
//  ProfileViewController.swift
//  Media
//
//  Created by 황예리 on 2023/08/29.
//

import UIKit

//Delegate - 1
protocol PassDataDelegate {
    func receiveDate(userName: String)
}

class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    
    override func loadView() {
        
        self.view = mainView
        
        mainView.nameButton.addTarget(self, action: #selector(nameButtonClicked), for: .touchUpInside)
        mainView.userNameButton.addTarget(self, action: #selector(userNameButtonClicked), for: .touchUpInside)
        mainView.genderButton.addTarget(self, action: #selector(genderButtonClicked), for: .touchUpInside)
        
        //Notification - 3
        NotificationCenter.default.addObserver(self, selector: #selector(genderButtonNotificationObserver(notification:)), name: NSNotification.Name.selectGender, object: nil)
    }
    
    @objc func nameButtonClicked() {
        let vc = NameViewController()
        
        //Closure - 3
        vc.completionHandler = { name  in
            self.mainView.nameButton.setTitle(name, for: .normal)
            print("completionHandler", name)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func userNameButtonClicked() {
        let vc = UserNameViewController()
        
        //Delegate - 5
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func genderButtonClicked() {
        let vc = GenderViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //Notification - 2
    @objc func genderButtonNotificationObserver(notification: NSNotification) {
        print(#function)
        if let gender = notification.userInfo?["gender"] as? String {
            print(gender)
            mainView.genderButton.setTitle(gender, for: .normal)
        }
    }
    
}

//Delegate - 4
extension ProfileViewController: PassDataDelegate {
    
    func receiveDate(userName: String) {
        mainView.userNameButton.setTitle(userName, for: .normal)
    }
    
}
