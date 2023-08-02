//
//  TimelineViewController.swift
//  Diary
//
//  Created by 황예리 on 2023/08/02.
//

import UIKit

/*
    230802
    1. 프로토콜(ex. 부하직원): UICollectionViewDelegate, UICollectionViewDataSource
    2. 컬렉션뷰와 부하직원을 연결: delegate = self (타입으로서 프로토콜 사용)
    3. 컬렉션뷰 아웃렛
 */


class TimelineViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource { // 첫번째는 상속을 받고있고, 나머지는 프로토콜
    
    @IBOutlet var todayCollectionView: UICollectionView!
    @IBOutlet var bestCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todayCollectionView.delegate = self
        todayCollectionView.dataSource = self
        
        bestCollectionView.delegate = self
        bestCollectionView.dataSource = self
        
        //XIB 등록
        let nib = UINib(nibName: SearchCollectionViewCell.identifier, bundle: nil)
        todayCollectionView.register(nib, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        bestCollectionView.register(nib, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        
        configureTodayCollectionViewLayout()
        configureBestCollectionViewLayout()
    }
    
    func configureTodayCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        todayCollectionView.collectionViewLayout = layout
    }
    
    func configureBestCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        bestCollectionView.collectionViewLayout = layout
        //deviceWidth 기준으로 움직임
        bestCollectionView.isPagingEnabled = true // page 효과
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //collectionView 마다 다른 셀 갯수 적용
        return collectionView == todayCollectionView ? 3 : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell // 재사용 코드
       
        if collectionView == todayCollectionView {
            cell.contentLable.text = "Today: \(indexPath.item)"
            cell.backgroundColor = .yellow
        } else {
            cell.contentLable.text = "Best: \(indexPath.item)"
            cell.backgroundColor = [.systemCyan, .systemYellow, .systemRed, .systemMint].randomElement()
        }
        
        return cell
    }

    
   

}
