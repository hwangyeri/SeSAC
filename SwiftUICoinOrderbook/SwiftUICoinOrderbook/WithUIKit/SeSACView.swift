//
//  SeSACView.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/27.
//

import SwiftUI

struct SeSACView: View {
    
    @State private var textFieldText = "SwiftUI 텍스트" // SOT: Source of Truths
    @State private var uiKitTextFieldText = "UIKit 텍스트"
    
    var body: some View {
        VStack {
            Text(textFieldText)
            TextField("SwiftUI 텍스트필드입니다.", text: $textFieldText) // 하위뷰라서 데이터 전달이 필요
            VStack {
                Text(uiKitTextFieldText)
                MyTextField(text: $uiKitTextFieldText) // UIKit 랩핑해서 쓰고있는 객체
            }
            .background(.gray)
            .padding()
            MyWebView(url: "https://www.apple.com")
        }
    }
}

#Preview {
    SeSACView()
}
