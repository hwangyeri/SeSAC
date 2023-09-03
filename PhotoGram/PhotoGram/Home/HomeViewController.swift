//
//  HomeViewController.swift
//  PhotoGram
//
//  Created by 황예리 on 2023/08/31.
//

import UIKit

// protocol 1.
//AnyObject: 클래스에서만 프로토콜을 정의할 수 있도록 제약
protocol HomeViewProtocol: AnyObject {
    // 셀 선택한 걸 넘겨주기
    func didSelectItemAt(indexPath: IndexPath)
}

class HomeViewController: BaseViewController {
    
    weak var delegate: PassWebImageDelegate?
    
    // 3. 식판
    var list: Photo = Photo(total: 0, total_pages: 0, results: []) // 비어있는 리스트를 가지고 로드 전에 컬렉션 뷰가 한번 그려짐
    
    let mainView = HomeView()
    
    override func loadView() {
        //super.loadView() // 커스텀하게 쓸거면 super 메서드 호출 X
        //let view = HomeView()
        
        // protocol 3.
        mainView.delegate = self
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        mainView.collectionView.delegate = self // 뷰컨에서 컬렉션 뷰의 역할을 할 수 있도록 전환한 상태
        mainView.collectionView.dataSource = self
        
        mainView.searchBar.becomeFirstResponder()
        mainView.searchBar.delegate = self
    }
    
    deinit {
        print(self, #function, "======")
    }
    
}

// protocol 4.
extension HomeViewController: HomeViewProtocol {
    
    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath)
        navigationController?.popViewController(animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function) // 동작에 대한 이해가 잘 안되면 프린트 찍어보기!
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.backgroundColor = .systemBlue
        
        let thumb = list.results[indexPath.item].urls.thumb
        let url = URL(string: thumb) // 링크를 기반으로 이미지를 보여준다? >>> 네트워크 통신임 !!! // String -> URL
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url!) // URL -> Data
            //동기 코드, 하나하나씩 진행됨 -> DispatchQueue로 비동기 코드로 변경
            
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data) // UI 작업은 main에서 할 수 있도록 변경
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        // 화면전환, 얼럿 못띄움 // navigation-push/pop, present-dismiss -> ViewController 에서만 할 수 있음
        // ViewController가 해당 기능을 할 수 있도록 처리, 신호를 받아 실행할 수 있게끔 Delegate Patten을 이용해서 명령함
        //        delegate?.didSelectItemAt(indexPath: indexPath) // HomeView 에서 사용하던 것이라 주석처리
        
        let selectedImageURL = list.results[indexPath.item].urls.full
        
        DispatchQueue.global().async { [weak self] in
            if let url = URL(string: selectedImageURL),
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    self?.delegate?.receiveWebImage(image: image)
                    print(selectedImageURL)
                }
            }
        }
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else {
            // FIXME: 검색어가 비어있는 경우에 대한 처리 (ex. Alert)
            return
        }
        
        mainView.searchBar.resignFirstResponder()
        
        APIService.shared.callRequest(query: query) { photo in
            guard let photo = photo else {
                print("ALERT ERROR")
                return
            }
            
            // 4. 배열(뷰) - 데이터 리스트에 넣기
            print("API END")
            self.list = photo //네트워크 전후로 데이터가 변경됨.
            
            self.mainView.collectionView.reloadData()
            // 그렇기때문에 데이터 갱신이 필요함, UI 업데이트 관련해서는 main이 진행하도록 변경 // main 코드 -> APIService 내부 구현으로 수정
        }
    }
}

