//
//  LottoViewController.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/13.
//

import UIKit

class LottoViewController: UIViewController {
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    @IBOutlet var label6: UILabel!
    @IBOutlet var label7: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var viewModel = LottoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewModel.fetchLottoAPI(drwNo: 1000)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            self.viewModel.fetchLottoAPI(drwNo: 1022)
        }
        
        bindData()
    }
    
    func bindData() {
        
        viewModel.number1.bind { value in
            self.label1.text = self.viewModel.calculate(drwtNo: 1, value: value)
        }
        
        viewModel.number2.bind { value in
            self.label2.text = self.viewModel.calculate(drwtNo: 2, value: value)
        }
        
        viewModel.number3.bind { value in
            self.label3.text = self.viewModel.calculate(drwtNo: 3, value: value)
        }
        
        viewModel.number4.bind { value in
            self.label4.text = self.viewModel.calculate(drwtNo: 4, value: value)
        }
        
        viewModel.number5.bind { value in
            self.label5.text = self.viewModel.calculate(drwtNo: 5, value: value)
        }
        
        viewModel.number6.bind { value in
            self.label6.text = self.viewModel.calculate(drwtNo: 6, value: value)
        }
        
        viewModel.number7.bind { value in
            self.label7.text = self.viewModel.calculate(drwtNo: 7, value: value)
        }
        
        viewModel.lottoMoney.bind { money in
            self.dateLabel.text = money
        }
    }
    

}
