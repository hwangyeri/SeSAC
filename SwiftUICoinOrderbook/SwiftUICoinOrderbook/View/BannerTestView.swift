//
//  BannerTestView.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/21.
//

import SwiftUI

struct BannerTestView: View {
    
    @Binding var testNumber: Int
    
    var body: some View {
        VStack {
            Text("테스트: \(testNumber)")
            
            Button("숫자 업데이트") {
                testNumber = Int.random(in: 1...100)
            }
        }
    }
}

#Preview {
    BannerTestView(testNumber: .constant(5))
}
