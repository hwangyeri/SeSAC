//
//  SearchViewController.swift
//  PhotoGram
//
//  Created by 황예리 on 2023/08/28.
//

import UIKit

class SearchViewController: BaseViewController {
    
    let mainView = SearchView() // 제어를 위해 클래스가 가진 아울렛이나 객체를 가져올때 별도의 인스턴스를 만들어둬야 접근이 쉬움
    
    let imageList = ["pencil", "star.fill", "person", "xmark", "person.circle"]
    
    // 2. 부하직원 등록, 딜리게이트를 가지고 있는 데이터를 원하는 시점에 담아서 보내줄 수 있음
    var delegate: PassImageDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //addObserver보다 post가 먼저 신호를 보내면 addObserver가 신호를 받지 못한다!
        NotificationCenter.default.addObserver(self, selector: #selector(recommendKeywordNotificationObserver(notification:)), name: NSNotification.Name("RecommendKeyword"), object: nil)
        
        mainView.searchBar.becomeFirstResponder() // 커서가 바로 깜빡일 수 있게 만듦
        mainView.searchBar.delegate = self
    }
    
    @objc func recommendKeywordNotificationObserver(notification: NSNotification) {
        print("recommendKeywordNotificationObserver")
    }
    
    override func configureView() {
        super.configureView()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        //mainView.collectionViewLayout() // 'collectionViewLayout' is inaccessible due to 'private' protection level
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.image = UIImage(systemName: imageList[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(imageList[indexPath.item])
        
        //Protocol을 통한 값 전달 // 3. 딜리게이트로 원하는 시점에 어떤 데이터를 보낼지
        delegate?.receiveImage(image: UIImage(systemName: imageList[indexPath.item])!)
        
        //Notification을 통한 값 전달
        //NotificationCenter.default.post(name: NSNotification.Name("SelectImage"), object: nil, userInfo: ["name": imageList[indexPath.item], "sample": "cookie" ]) // 신호랑 같이 값을 전달하기 위해서 userInfo 같이 전달
        
        dismiss(animated: true)
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        mainView.searchBar.resignFirstResponder() // 사용자의 포커스가 서치바에 없다고 명시적으로 설정
        
    }
}
