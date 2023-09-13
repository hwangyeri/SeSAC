//
//  PhotoViewController.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/12.
//

import UIKit

// 가져온 데이터가 DB 에서 가져온 데이터인지 더미 데이터인지 ViewController 은 모름

class PhotoViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchPhoto()
        
        viewModel.list.bind { _ in // 데이터가 바뀌면 뭘 해줄래?
            DispatchQueue.main.async {
                self.tableView.reloadData()
                // tableView.리로드는 UIKit 임포트 해야 사용 가능해서 VC 에 위치
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell")!
        let data = viewModel.cellForRowAt(at: indexPath)
       
        cell.backgroundColor = .lightGray
        
        viewModel.downloadImage(at: indexPath) { data in
            if let imageData = data {
                let image = UIImage(data: imageData)
                cell.imageView?.image = image
            } else {
                cell.imageView?.image = UIImage(systemName: "photo")
            }
        }
        
        return cell
    }
    
    
}

