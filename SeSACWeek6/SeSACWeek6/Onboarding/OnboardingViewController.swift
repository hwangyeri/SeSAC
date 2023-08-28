//
//  OnboardingViewController.swift
//  SeSACWeek6
//
//  Created by 황예리 on 2023/08/25.
//

import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
    }
}

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
    }
}

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .magenta
    }
}


class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    //1. 뷰컨트롤러 배열
    var pageViewControllerList: [UIViewController] = []
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //배열에 뷰컨트롤러 추가
        pageViewControllerList = [FirstViewController(), SecondViewController(), ThirdViewController()]
        configurePageViewController()
        
        view.backgroundColor = .lightGray
    }
    
    func configurePageViewController() {
        delegate = self // 스토리보드 상에서 내장된 기능
        dataSource = self
        
        //Display
        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true) // [list[0]] < [first]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? { // 이전 화면 준비
        //let example = [1,2,3,4,5,6,7,8]
        //example.firstIndex(of: 6) // 5 // 특정 요소 기반으로 인덱스 찾기
        
        //현재 페이지뷰컨트롤러에 보이는 뷰컨(viewController)의 인덱스 가져오기
        guard let currentIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        // 현재 사용자가 몇번째 인덱스에 있는지 알려줘, 그럴일 없지만 없다면 nil
        // 사용자 입장에서 현재 사용자가 위치한 인덱스 값을 가져옴
        
        let previousIndex = currentIndex - 1 // 이전 인덱스 가져오기
        
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex] // 현재 보고있는 인덱스보다 -1 인덱스의 화면을 보여줘
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? { // 다음 화면 준비
        
        //현재 페이지뷰컨트롤러에 보이는 뷰컨(viewController)의 인덱스 가져오기
        guard let currentIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int { // pageControl 점 개수
        return pageViewControllerList.count
    } // 점 위치, 컬러 변경 가능하지만 커스텀 뷰로 따로 만들어줘야함
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int { // pageControl 현재 인덱스 위치
        guard let first = viewControllers?.first, let index = pageViewControllerList.firstIndex(of: first) else { return 0 }
        return index
    }
    

}
