//
//  ContentViewModel.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/21.
//

import Foundation

// 데이터를 주고 받는 양이 많아지면 @State를 그룹으로 묶을 순 없을까?
// State보다 StateObject를 써야한다(X)보다는 다양한 방법이 있다 정도로 알기

// ViewModel에서 ObservableObject-Published 짝꿍으로 많이 쓰임

class ContentViewModel: ObservableObject { // ObservableObject는 관찰자, 달라지면 Published 통해서 뷰 업데이트를 해줘라!
    
    // Published 컴바인에 들어있는 기능 중 하나, 데이터가 바뀔때 마다 뷰 업데이트 해줌
    @Published var banner = Banner()
    @Published var money: [Market] = []
    
    func fetchBanner() {
        banner = Banner()
    }
    
}


//func fetchAllMarket() {
//    
//    let url = URL(string: "https://api.upbit.com/v1/market/all")!
//    
//    URLSession.shared.dataTask(with: url) { data, response, error in
//        guard let data = data else {
//            print("데이터 응답 없음")
//            return
//        }
//        
//        do {
//            let decodedData = try JSONDecoder().decode([Market].self, from: data)
//            
//            DispatchQueue.main.async {
//                self.money = decodedData // money 프로퍼티에 전달해줘서 completion 핸들러가 필요 없어짐
//            }
//            
//        } catch {
//            print(error)
//        }
//    }.resume()
//}
