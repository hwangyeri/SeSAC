//
//  VideoViewController.swift
//  SeSACWeek3
//
//  Created by 황예리 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

//struct Video {
//    let author: String
//    let date: String
//    let time: Int
//    let thumbnail: String
//    let title: String
//    let link: String
//
//    var contents: String { // 연산 프로퍼티는 변수만 가능
//        return "\(author) | \(time)회\n\(date)"
//    }
//}

class VideoViewController: UIViewController {
    
    var videoList: Video = Video(documents: [], meta: Meta(isEnd: false, pageableCount: 0, totalCount: 0))
    var page = 1
    var isEnd = false //현재 페이지가 마지막 페이지인지 점검하는 프로퍼티
    var pageableCount = 20
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var videoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.prefetchDataSource = self
        videoTableView.rowHeight = 140
        
        searchBar.delegate = self
        
        
    }

//    func callRequest(query: String, page: Int) {
//
//        KakaoAPIManager.shared.callRequest(type: .video, query: query) { json in
//            print("=======\(json)")
//        }
//
//        print(url) // 데이터가 잘 바뀌는지, 필요한 시점에 서버 통신이 잘 되는 지 확인
//
//         ex. validate(statusCode: 200...500) 성공 코드로 보겠다~ 설정도 가능
//         상태 코드에 대한 처리, 예외처리에 대한 대응이 필요
//        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
//            switch response.result { // response 매개변수
//            case .success(let value):
//                let json = JSON(value) // 상태 코드에 따라서 달라짐
//                print("JSON: \(json)")
//
//                print(response.response?.statusCode) // 상태 코드가 몇번인지에 대한 정보를 얻을 수 있음
//
//                let statusCode = response.response?.statusCode ?? 500
//
//                if statusCode == 200 {
//
//                    // isEnd 다음 페이지를 늘려줘야되는지 안 늘려줘야되는지 설정해야함
//                    self.isEnd = json["meta"]["is_end"].boolValue
//                    print(json["meta"]["is_end"].boolValue)
//
//                    for item in json["documents"].arrayValue {
//
//                        let author = item["author"].stringValue
//                        let date = item["datetime"].stringValue
//                        let time = item["play_time"].intValue
//                        let thumbnail = item["thumbnail"].stringValue
//                        let title = item["title"].stringValue
//                        let link = item["url"].stringValue
//
//                        let data = Video(author: author, date: date, time: time, thumbnail: thumbnail, title: title, link: link)
//
//                        self.videoList.append(data)
//                    }
//
//                    self.videoTableView.reloadData()
//                } else {
//                    print("문제가 발생했어요. 잠시 후 다시 시도해주세요!!")
//                }
//
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//    }

    
    
}

extension VideoViewController: UISearchBarDelegate {
    
    // 실시간 검색 호출은 위험할 수 도 있음, enter 눌렀을때 호출하기
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function, "함수 실행")
        //page = 1 //새로운 검색어이기 때문에 page를 1로 변경
        
//        videoList.documents.removeAll()
//        videoList.meta.pageableCount = 1
        
        guard let query = searchBar.text else { return } // 옵셔널 바인딩 처리
        print(query)
        
        KakaoAPIManager.shared.callRequest(type: .video, query: query) { data in
            print(data)
            self.videoList = data
            self.videoList.meta
            print(self.videoList.meta)
            
            self.isEnd = data.meta.isEnd
            print(self.isEnd)
            self.pageableCount = data.meta.pageableCount
            print(self.pageableCount)
            self.videoTableView.reloadData()
            
        } failure: {
            print(#function, "error")
            print(self.videoList)
            print(query)
        }
        

        //callRequest(query: query, page: page)
    }
}

//UITableViewDataSourcePrefetching: iOS10이상 사용 가능한 프로토콜, cellForRowAt 메서드가 호출되기 전에 미리 호출됨
extension VideoViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else { return VideoTableViewCell() }
        let row = videoList.documents[indexPath.row]
        
        let url = row.thumbnail
        cell.thumbnailImageView.kf.setImage(with: URL(string: url))
        cell.titleLabel.text = row.title
        cell.contentLabel.text = "\(row.author) | \(row.datetime) | \(row.playTime)"
        
        return cell
    }
    
    //셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능 // cellForRowAt 호출 전에 미리 호출되는 친구 - prefetchRowsAt(미리 다운로드)
    //videoList 갯수와 indexPath.row 위치를 비교해 마지막 스크롤 시점을 확인 -> 네트워크 요청 시도
    //page count // page는 default 1부터 시작
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if videoList.documents.count - 1 == indexPath.row && page < self.pageableCount && isEnd == false { // isEnd == false
                page += 1
                //callRequest(query: searchBar.text!, page: page)
                
                KakaoAPIManager.shared.callRequest(type: .video, query: searchBar.text!) { data in
                    print(data.documents.count)
                    
                    self.videoList.documents.append(contentsOf: data.documents)
                    print(self.videoList.documents.count)
                    
                    self.videoTableView.reloadData()
                } failure: {
                    print(#function, "error")
                }

            }
        }
    }
    
    //취소 기능: 직접 취소하는 기능을 구현해주어야 함!
    // 빠르게 스크롤 되는 버려지는 데이터, 다운로드 취소하는 아이
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("===취소: \(indexPaths)")
    }
    
    
}
