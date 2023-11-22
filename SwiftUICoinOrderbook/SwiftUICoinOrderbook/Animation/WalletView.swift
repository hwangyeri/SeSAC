//
//  WalletView.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/22.
//

import SwiftUI

struct WalletView: View {
    
    @State private var isExpandable = false //애니메이션 효과
    
    @State private var showDetail = false // 다음 화면 전환
    
    let wallet = walletList // wallet model list
    
    // 탭한 카드가 무엇인지 알기 위함
    @State private var currentWallet = WalletModel(name: "", index: 0)
    
    @Namespace var animation
    
    var body: some View {
        VStack {
            topTitle()
            cardSpace()
            Button("Animation On") {
                withAnimation(.bouncy) { // .delay(1): 버튼을 누르고 1초 뒤에 실행하겠다
                    isExpandable = true
                }
            }
            Button("Animation Off") {
                withAnimation(.bouncy) {
                    isExpandable = false
                }
            }
        }
        .overlay {
            if showDetail {
                WalletDetailView(
                    showDetail: $showDetail,
                    currentWallet: currentWallet,
                    animation: animation
                )
            }
        }
    }
    
    func cardSpace() -> some View {
        ScrollView {
            ForEach(wallet, id: \.self) { item in
                cardView(item)
            }
        }
        .overlay {
            Rectangle()
                .fill(.black.opacity(isExpandable ? 0 : 0.01)) 
                // HIG 최소 알파값 0.01
                // 알파값이 0이 되면 사용자 눈에 보이지않고, 클릭할 수 없는 상태가 됨
                .onTapGesture {
                    withAnimation {
                        isExpandable = true
                    }
                }
        }
    }
    
    func cardView(_ data: WalletModel) -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(data.color)
            .frame(height: 150)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .offset(
                y: CGFloat(data.index) * (isExpandable ? 0 : -130)
            )
            .onTapGesture {
                withAnimation {
                    currentWallet = data
                    //카드 탭 시 다음 화면 전환
                    showDetail = true
                }
            }
            .matchedGeometryEffect(id: data, in: animation)
    }
    
    func topTitle() -> some View {
        Text("Yeri Wallet")
            .font(.largeTitle)
            .bold()
            .frame(
                maxWidth: .infinity,
                alignment: isExpandable ? .leading : .center
            )
            .overlay(alignment: .trailing) {
                topOverlayButton()
            }
            .padding()
    }
    
    func topOverlayButton() -> some View {
        Button {
            withAnimation {
                isExpandable = false
            }
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.white)
                .padding()
                .background(.black, in: Circle())
        }
        .rotationEffect(.degrees(isExpandable ? 225 : 45))
        // degrees: 몇도를 회전시킬건지, 90/180/270은 애니메이션 안보임
        .opacity(isExpandable ? 1 : 0)
    }
}

#Preview {
    WalletView()
}
