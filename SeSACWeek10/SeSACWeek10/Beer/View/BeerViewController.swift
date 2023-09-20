//
//  BeerViewController.swift
//  SeSACWeek10
//
//  Created by 황예리 on 2023/09/20.
//

import UIKit
import SnapKit
import Kingfisher

class BeerViewController: UIViewController {
    
    private let imageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let mainLabel: BeerLabel = {
        let view = BeerLabel(fontSize: 16, textColor: .systemRed)
        return view
    }()
    
    private let subLabel: BeerLabel = {
        let view = BeerLabel(fontSize: 14, textColor: .label)
        return view
    }()
    
    let viewModel = BeerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        configureHierachy()
        configureLayout()

        viewModel.request(api: .randomBeer) { result in
            switch result {
            case .success(let beer):
                
                if let imageURL = URL(string: beer[0].imageURL) {
                    self.imageView.kf.setImage(with: imageURL)
                }
                
                self.mainLabel.text = beer[0].name
                self.subLabel.text = beer[0].tagline
                
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
    private func configureLayout() {
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(50)
        }

        subLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(mainLabel.snp.bottom).offset(10)
            make.size.equalTo(mainLabel)
        }
    }
    
    func configureHierachy() {
        view.addSubview(imageView)
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
    }
    

}
