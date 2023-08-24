//
//  Extension+UIViewController.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/24.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present //네비게이션 없이 present
        case presentNavigation // 네비게이션 임베드 된 present
        case presentFullNavigation // 네비게이션 임베드 된 fullScreen present
        case push
    }
    
    /*
     "고래밥" > String
     String.self > String.Type
     */
    func transition<T: UIViewController>(viewController: T.Type, storyboard: String, style: TransitionStyle) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: String(describing: viewController)) as? T else { return }
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    //Type Parameter: 타입의 종류는 알려주지 않지만, 모두 같은 타입이 들어갈 것을 암시. 플레이스 홀더와 같은 역할 // T
    //Type Constraints: 클래스 제약, 프로토콜 제약
    //UpperCased // U 두번째로 많이 씀
    func configureBorder<T: UIView>(view: T) { // UIView 에 대한 특성을 가지고 있어야 들어올 수 있도록 제약조건
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
    }
    
    func configureBorder(view: UIButton) {
        
    }
    
    func configureBorder(view: UIImageView) {
        
    }
    
    func configureBorder(view: UITextView) {
        
    }
    
    //Generic: 타입에 유연하게 대응하기 위한 요소
    //코드 중복과 재사용에 대응하기가 좋아서 추성적인 표현 가능
    func sum<T: AdditiveArithmetic>(a: T, b: T) -> T { // AdditiveArithmetic 플러스 계산이 가능한 프로토콜이 들어온다고 정의
        return a + b
    }
    
    func sumInt(a: Int, b: Int) -> Int {
        return a + b
    }
    
    func sumDouble(a: Double, b: Double) -> Double {
        return a + b
    }
    
    func sumFloat(a: Float, b: Float) -> Float {
        return a + b
    }
    
    
}
