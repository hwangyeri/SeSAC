//
//  HorizontalViewModel.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/27.
//

import SwiftUI

class HorizontalViewModel: ObservableObject { // 관찰자 역할, ObservableObject 프로토콜을 채택해야 데이터가 변경되면 신호를 보내주게 됨
    
    @Published var value = 0.0 // 신호를 보내는 친구
    @Published var dummy: [HorizontalData] = []
    
    @Published var askOrderBook: [OrderBookItem] = []
    @Published var bidOrderBook: [OrderBookItem] = []
    
    let market: Market
    
    init(market: Market) { // 클래스라서 프로퍼티 초기화 필요
        self.market = market
    }
    
    func fetchOrderbook() {
        
        let url = URL(string: "https://api.upbit.com/v1/orderbook?markets=KRW-BTC")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            print("- !! data -", data, "- !! response -", response, "- !! error -", error)
            
            guard let data = data else {
                print("데이터 응답 없음")
                return
            }
            
            do {
                // 서버 응답 값을 JSONDecoder 활용해서 OrderBookModel 배열에 넣어줌
                let decodedData = try JSONDecoder().decode([OrderBookModel].self, from: data)
                
                DispatchQueue.main.async {
                    // decodedData.first == decodedData[0]
                    // 런타임 이슈 발생 유무 차이, [0]는 100% 있다는 보장하에 가져오는 것이라
                    // 옵셔널 체이닝을 해줘야한다는 불편함이 있지만 first가 더 안전함
                    let result = decodedData.first?.orderbook_units ?? [OrderBookUnit(ask_price: 0, bid_price: 0, ask_size: 0, bid_size: 0)]
                    
                    let ask = result.map { OrderBookItem(price: $0.ask_price, size: $0.ask_size) }.sorted(by: { $0.price > $1.price })
                    
                    let bid = result.map { OrderBookItem(price: $0.bid_price, size: $0.bid_size) }.sorted(by: { $0.price > $1.price })
                    
                    self.askOrderBook = ask
                    self.bidOrderBook = bid
                    print("- !! askOrderBook -", self.askOrderBook, "- !! bidOrderBook -", self.bidOrderBook)
                }
                
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func largestAskSize() -> Double {
        return askOrderBook.sorted(by: { $0.size > $1.size }).first!.size
    }
    
    func largestBidSize() -> Double {
        return bidOrderBook.sorted(by: { $0.size > $1.size }).first!.size
    }
    
    func timer() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            self.value += 5
//            self.fetchDummyData()
            self.fetchOrderbook()
            //Dummy data가 달라지도록 구성
        }
    }
    
    func fetchDummyData() { // 이 데이터를 서버랑 연결해서 확장시킴
        
        dummy = [
            HorizontalData(data: "사과"),
            HorizontalData(data: "포도"),
            HorizontalData(data: "바나나"),
            HorizontalData(data: "복숭아"),
            HorizontalData(data: "귤"),
            HorizontalData(data: "딸기"),
            HorizontalData(data: "참외"),
            HorizontalData(data: "수박"),
            HorizontalData(data: "멜론")
        ]
        
    }
    
    func largest() -> Int { // 차트 데이터가 일정 숫자를 가질 때, 최소/최대 범주를 명확하기 설정하기 어려워서 최대 단위를 작성한 것
        let data = dummy.sorted(by: { $0.point > $1.point })
        return data.first!.point
    }

}
