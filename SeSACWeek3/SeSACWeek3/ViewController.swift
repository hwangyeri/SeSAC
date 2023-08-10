//
//  ViewController.swift
//  SeSACWeek3
//
//  Created by 황예리 on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Movie { // movieList -> struct Movie 로 확장, 왜 구조체를 사용하나? 상속해줄거아니니깐 클래스 사용할 필요없음, 리터럴한 데이터는 구조체로
    var title: String
    var release: String
}

class ViewController: UIViewController {

    // 1. 아울렛 연결
    @IBOutlet var movieTableView: UITableView!
    
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var searchBar: UISearchBar!
    
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.rowHeight = 60
        // 3. 부하직원 연결
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        //callRequest() 화면을 시작할때 더이상 서버통신x
        indicatorView.isHidden = true
    }
    

    func callRequest(date: String) {
        
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        
        // key에 대한 관리, 매우 중요
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=\(date)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
//                let name1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
//                let name2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
//                let name3 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue
//
//                print(name1, name2, name3)
                //self.movieList.append(name1)
                //self.movieList.append(name2)
                //self.movieList.append(name3)
                
//                self.movieList.append(contentsOf: [name1, name2, name3])
            
            for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue { // 인덱스 접근하기 전까지의 키를 배열로 돌겠다
                
                let movieNm = item["movieNm"].stringValue
                let openDt = item["openDt"].stringValue
                
                let data = Movie(title: movieNm, release: openDt)
                self.movieList.append(data)
                
            }
            
            self.indicatorView.stopAnimating() // stop 하지않으면 숨김 처리되서 뒤에서 계속 돌아감
            self.indicatorView.isHidden = true
            self.movieTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    

}

// 2. 부하직원 등록
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell")!
        cell.textLabel?.text = movieList[indexPath.row].title
        cell.detailTextLabel?.text = movieList[indexPath.row].release
        
        return cell
    }
    
    
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //20220101 > 1. 8글자 2. 20233333 올바른 날짜 3. 날짜 범주
        callRequest(date: searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
