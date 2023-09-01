//
//  URLSessionViewController.swift
//  PhotoGram
//
//  Created by 황예리 on 2023/08/30.
//

import UIKit

class URLSessionViewController: UIViewController {
    
    var session: URLSession! // URLSession 여기로 들어올거야
    
    var total: Double = 0
    
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(String(format: "%.1f", result * 100))%" // "\(result * 100)%"
            print(result, total)
        }
    }
    
    let progressLabel = {
        let view = UILabel()
        view.backgroundColor = .black
        view.textColor = .white
        return view
    }()
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buffer = Data() //buffer?.append(data)가 실행되기 위함 // nil 데이터를 초기화해서 nil 이 아닌 상태로 만들어주기
        
        view.addSubview(progressLabel)
        view.addSubview(imageView)
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        
        view.backgroundColor = .white
        
        let url = URL(string:
                        "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        //https://api.unsplash.com/search/photos?query=\()?sky&client_id=\()
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main) // 내부적인 통신은 백그라운드에서 처리될 수 있지만 응답이 오고 나서는 main에서 처리될 수 있도록 만듦
        session.dataTask(with: url!).resume() // response 에 대한 지점이 달라서 코드가 확 줄어보이지만 shared 코드랑 원리는 같음
        
    }
    
    //카카오톡 사진 다운로드: 다운로드 중에 다른 채팅방으로 넘어가면? 취소 버튼?
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //취소 액션(화면이 사라질 때 등)
        //리소스 정리, 실행 중인 것도 무시
        session.invalidateAndCancel()
        
        //기다렸다가 리소스 끝나면 정리 // 다운로드 중인 것까지만 하고 나머지 정리
        session.finishTasksAndInvalidate()
    }
    
}

extension URLSessionViewController: URLSessionDataDelegate {
    
    //서버에서 최초로 응답 받은 경우에 호출(상태코드 처리) // 100MB
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print("RESPONSE:", response)
        
        if let response = response as? HTTPURLResponse,
           (200...500).contains(response.statusCode) {
            
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!)!
            
            return .allow // 상태코드가 문제가 없는게 확인되면 허락
        } else {
            return .cancel // 문제가 있으면 더이상 실행되지 않도록 취소
        }
    }
    
    //서버에서 데이터 받을 때마다 반복적으로 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("DATA:", data) // 1600
        buffer?.append(data) //buffer가 nil 이면 append 구문 실행 X // 옵셔널 체이닝 buffer? nil 이면 뒤에 코드 실행 X
    }
    
    //서버에서 응답이 완료가 된 이후에 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("END")
        
        if let error {
            print(error)
        } else {
            
            guard let buffer = buffer else {
                print(error)
                return
            }
            
            imageView.image = UIImage(data: buffer)
        }
    }
    
}
