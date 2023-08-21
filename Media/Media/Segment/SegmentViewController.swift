//
//  SegmentViewController.swift
//  Media
//
//  Created by 황예리 on 2023/08/18.
//

import UIKit

class SegmentViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var segment: UISegmentedControl!
    
    var similarList: Similar = Similar(page: 0, results: [], totalPages: 0, totalResults: 0)
    var videoList: Video = Video(id: 0, results: [])
    var selectedMovieID: Int = 642
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: SimilarCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SimilarCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: VideoCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        
//        SimilarAPIManager.shared.callRequest(movieID: selectedMovieID) { data in
//            self.similarList = data
//            print("*** SimilarAPIManager data success ***", self.similarList)
//            self.collectionView.reloadData()
//        } failure: {
//            print(#function, "error")
//        }
//
//        VideoAPIManager.shared.callRequest(movieID: selectedMovieID) { data in
//            self.videoList = data
//            print("*** VideoAPIManager data success ***", self.videoList)
//            self.collectionView.reloadData()
//        } failure: {
//            print(#function, "error")
//        }
        
        let group = DispatchGroup()
        
        group.enter()
        SimilarAPIManager.shared.callRequest(movieID: selectedMovieID) { data in
            self.similarList = data
            print("*** SimilarAPIManager data success ***", self.similarList)
            group.leave()
        } failure: {
            print(#function, "error")
            group.leave()
        }
        
        group.enter()
        VideoAPIManager.shared.callRequest(movieID: selectedMovieID) { data in
            self.videoList = data
            print("*** VideoAPIManager data success ***", self.videoList)
            group.leave()
        } failure: {
            print(#function, "error")
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.collectionView.reloadData()
            self.configureCollectionViewLayout()
        }
        
        
        configureCollectionViewLayout()
    }
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            SimilarAPIManager.shared.callRequest(movieID: selectedMovieID) { data in
                self.similarList = data
                print("*** SimilarAPIManager data success ***", self.similarList)
                self.collectionView.reloadData()
            } failure: {
                print(#function, "error")
            }
        } else {
            VideoAPIManager.shared.callRequest(movieID: selectedMovieID) { data in
                self.videoList = data
                print("*** VideoAPIManager data success ***", self.videoList)
                self.collectionView.reloadData()
            } failure: {
                print(#function, "error")
            }
        }
    }
    
    
    
}

extension SegmentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if segment.selectedSegmentIndex == 0 {
            return similarList.results.count
        } else {
            return videoList.results.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if segment.selectedSegmentIndex == 0 {
            guard let similarCell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarCollectionViewCell.identifier, for: indexPath) as? SimilarCollectionViewCell else { return UICollectionViewCell() }
            
            let similarData = similarList.results[indexPath.row]
            similarCell.configureSimilarCell(with: similarData)
            
            return similarCell
        } else {
            guard let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as? VideoCollectionViewCell else { return UICollectionViewCell() }
            
            let videoData = videoList.results[indexPath.row]
            videoCell.configureVideoCell(with: videoData)
            
            return videoCell
        }
        
    }
    
    func configureCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
    }
    
    
    
}
