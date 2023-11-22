//
//  WalletDetailView.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/22.
//

import SwiftUI

struct WalletDetailView: View {
    
    @Binding var showDetail: Bool //화면 dismiss (overlay false)
    
    let currentWallet: WalletModel //WalletView에서 선택한 card 정보
    
    var animation: Namespace.ID //동일한 그룹임을 인식
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(currentWallet.color)
                    .frame(height: 150)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .onTapGesture {
                        withAnimation {
                            showDetail = false
                        }
                    }
                    .matchedGeometryEffect(id: currentWallet, in: animation)
                Text(currentWallet.name)
                Spacer()
            }
        }
    }
}
