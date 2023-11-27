//
//  MyWebView.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/27.
//

import SwiftUI
import WebKit

//SwiftUI 프로젝트 UIKit 객체들을 활요하는 방법 => UIViewRepresentable

struct MyWebView: UIViewRepresentable {
    
    // associatedtype == Generic 프로토콜에서 제네릭을 쓸 수 없어서 제네릭처럼 쓰이는게 associatedtype
    // 필수적으로 들어가는 함수 2개: 만들어주는 함수 makeUIView, 업데이트 해주는 updateUIView
    // typealias에 명시해서 사용해도 됨, 취향차이
    
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        let webView = WKWebView()
        let request = URLRequest(url: url)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
