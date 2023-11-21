//
//  ListViewModel.swift
//  SwiftUICoinOrderbook
//
//  Created by Yeri Hwang on 2023/11/21.
//

import Foundation

class ListViewModel: ObservableObject {
    
    /*
     - Hashable의 특성: 다 못보여줘, 값이 똑같아서 하나만 보여줌, ForEach 에서 id가 아닌 self
     
     ForEach<Array<Market>, Market, ModifiedContent<HStack<TupleView<(VStack<TupleView<(Text, Text)>>, Spacer, Text)>>, _PaddingLayout>>: the ID Market(market: "a", korean: "b", english: "c") occurs multiple times within the collection, this will give undefined results!
     LazyVStackLayout: the ID Market(market: "a", korean: "b", english: "c") is used by multiple child views, this will give undefined results!
     */
    
    @Published var market = [
        Market(market: "a", korean: "b", english: "c"),
        Market(market: "a", korean: "b", english: "c"),
        Market(market: "a", korean: "b", english: "c")
    ]
    
    func fetchAllMarket() {
        
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("데이터 응답 없음")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Market].self, from: data)
                
                DispatchQueue.main.async {
                    self.market = decodedData
                }
                
            } catch {
                print(error)
            }
        }.resume()
    }
    
}
