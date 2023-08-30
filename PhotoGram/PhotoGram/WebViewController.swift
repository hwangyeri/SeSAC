//
//  WebViewController.swift
//  PhotoGram
//
//  Created by 황예리 on 2023/08/29.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView = WKWebView() // 초기화 해주기
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(100)
        }
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        //네비게이션 컨트롤러가 처음에 투명, 스크롤하면 불투명
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .red
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
        title = "웹뷰의 타이틀"
    
    }
    
    //MARK: - WebView Bottom Button
    func reloadButtonClicked() {
        webView.reload() // 새로고침
    }
    
    func goBackButtonClicked() {
        if webView.canGoBack {
            webView.goBack() // 뒤로가기
        }
    }
    
    func goForwardButtonClicked() {
        if webView.canGoForward {
            webView.goForward() // 앞으로가기
        }
    }
    
    
}
