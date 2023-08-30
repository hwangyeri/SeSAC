//
//  URLSessionViewController.swift
//  PhotoGram
//
//  Created by 황예리 on 2023/08/30.
//

import UIKit

class URLSessionViewController: UIViewController {
    
    var session: URLSession! // URLSession 여기로 들어올거야

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string:
                        "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        //https://api.unsplash.com/search/photos?query=\()?sky&client_id=\()
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: url!).resume() // response 에 대한 지점이 달라서 코드가 확 줄어보이지만 shared 코드랑 원리는 같음
        
        
    }
    
}

extension URLSessionViewController: URLSessionDataDelegate {
    
    //서버에서 최초로 응답 받은 경우에 호출(상태코드 처리)
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
//        print("RESPONSE:", response)
//    }
    
    //서버에서 데이터 받을 때마다 반복적으로 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("DATA:", data)
    }
    
    //서버에서 응답이 완료가 된 이후에 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("END")
    }
    
}
