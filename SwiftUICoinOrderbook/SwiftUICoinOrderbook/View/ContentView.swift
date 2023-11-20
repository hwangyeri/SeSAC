//
//  ContentView.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var banner = "23,456,789,467,700원"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    bannerView()
                    Button("테스트") {
                        
                    }
                    Spacer()
                    Button("데이터 로드") {
                        
                    }
                    LazyVStack { // 필요한 시점에 로드
                        ForEach(1..<50) { data in
                            listView(data: data)
                        }
                    }
                }
            }
            .refreshable { //iOS15+
                banner = "54,324,243원"
            }
            .navigationTitle("Yeri Wallet")
        }
    }
    
    func bannerView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.indigo)
                .frame(maxWidth: .infinity)
                .frame(height: 180)
            
            VStack(alignment: .leading) {
                Spacer()
                Text("나의 소비내역")
                Text(banner)
                    .font(.title)
                    .bold()
            }
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
    
    func listView(data: Int) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("비트코인 \(data)")
                    .font(.title3)
                Text("Bitcoin \(data)")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .bold()
            Spacer()
            Text("KRW-BTC")
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
    }
    
}

#Preview {
    ContentView()
}
