//
//  LottoViewModel.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/13.
//

import Foundation

class LottoViewModel {
    
    var number1 = Observable(1)
    var number2 = Observable(1)
    var number3 = Observable(1)
    var number4 = Observable(1)
    var number5 = Observable(1)
    var number6 = Observable(1)
    var number7 = Observable(1)
    var lottoMoney = Observable("당첨금")
    
    func format(for number: Int) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: number)!
    }
    
    func fetchLottoAPI(drwNo: Int) {
        
        LottoAPIService.shared.callRequest(number: drwNo) { lotto, error in
            
            guard let lotto = lotto else {
                return
            }
            
            self.number1.value = lotto.drwtNo1
            self.number2.value = lotto.drwtNo2
            self.number3.value = lotto.drwtNo3
            self.number4.value = lotto.drwtNo4
            self.number5.value = lotto.drwtNo5
            self.number6.value = lotto.drwtNo6
            self.number7.value = lotto.bnusNo
            self.lottoMoney.value = self.format(for: lotto.totSellamnt)
            
        }
    }
    
    func calculate(drwtNo: Int, value: Int) -> String {
        return "drwtNo\(drwtNo)\n\(value)"
    }
    
}
