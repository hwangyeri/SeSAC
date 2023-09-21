//
//  ViewController.swift
//  SeSACWeek10
//
//  Created by 황예리 on 2023/09/19.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    private lazy var scrollView = {
        let view = UIScrollView()
        view.backgroundColor = .green
        view.minimumZoomScale = 1
        view.maximumZoomScale = 4
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self // 확대, 취소 기능 추가
        // lazy 를 통해서 self 키워드를 쓸 수 있는 상황을 만든 후 초기화
        return view
    }()
    
    private let imageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true // 사용자 제스처 허용
        return view
    }()
    
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy() // 순서 중요
        configureLayout()
        configureGesture()
        
        viewModel.request { url in
            self.imageView.kf.setImage(with: url) // 링크를 이미지에 보여주기만 하지 어떤 스트링이 왔는지 모름
        }
    }
    
    private func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
        tap.numberOfTapsRequired = 2 // 몇변의 탭을 요구할건지
        imageView.addGestureRecognizer(tap) // 어디에 추가할건지
    }
    
    @objc private func doubleTapGesture() {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(2, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    private func configureLayout() { // 위치 조정
        scrollView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalTo(view)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView)
        }
    }
    
    func configureHierachy() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}

//Codable: Decodable + Encodable
struct Photo: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

// Codable 이 아닌 Decodable 인 이유 => 가지고 와서 구조체에 넣어주고 있어서 Decodable 만 해도 충분!
struct PhotoResult: Decodable { 
    let id: String
    let created_at: String
    let urls: PhotoURL
}

struct PhotoURL: Decodable {
    let full: String
    let thumb: String
}

/*
 
 override func viewDidLoad() {
     super.viewDidLoad()
     
//        // (Photo?, Error?)
//        NetworkBasic.shared.random { photo, error in // 둘다 nil 값을 받고 있으니깐 옵셔널 바인딩 필요
//            guard let photo = photo else { return } // guard 문에서 return 은 early exit 이라 위험함
//            guard let error = error else { return } // <= 어딘가 이상한 코드?
//        }
     
//        // ResultType
//        NetworkBasic.shared.detailPhoto(id: "") { response in // response 라는 하나의 매개변수가 성공/실패 중 하나로 반환해줌
//            switch response { // If 문 보다는 switch 문 많이 사용하는 편
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
     
//        // search
//        Network.shared.request(type: Photo.self, api: .search(query: "apple")) { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                print(failure.errorDescription)
//            }
//        }
     
//        // random
//        Network.shared.request(type: PhotoResult.self, api: .random) { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                print(failure.errorDescription)
//            }
//        }
     
//        // detail
//        Network.shared.request(type: PhotoResult.self, api: .photo(id: "vVXvs2em8Ok")) { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                print(failure.errorDescription)
//            }
//        }
     
 }
 
 */

