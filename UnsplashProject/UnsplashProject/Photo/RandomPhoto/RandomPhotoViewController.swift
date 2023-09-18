//
//  RandomPhotoViewController.swift
//  UnsplashProject
//
//  Created by 황예리 on 2023/09/18.
//

import UIKit
import SnapKit

struct RandomPhoto: Hashable {
    
    let url: String
    let id = UUID().uuidString
}

class RandomPhotoViewController: UIViewController {
    
    // https://source.unsplash.com/featured/?sky
    // https://source.unsplash.com/random/300×300
    
    enum Section: Int, CaseIterable {
        case first = 1
    }
    
    var viewModel = RandomPhotoViewModel()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    // extension UICollectionViewDataSource
    var dataSource: UICollectionViewDiffableDataSource<Section, RandomPhoto>!

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configurationDataSource()
        updateSnapshot()
        
        viewModel.list.bind { randoom in
            self.updateSnapshot()
        }
        
    }
    
    static private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemBackground
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    // extension UICollectionViewDataSource - numberOfItemsInSection
    func updateSnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, RandomPhoto>()
        
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(viewModel.list.value, toSection: Section.first)
        
        dataSource.apply(snapshot) // collectionView.reloadData()
    }
    
    // extension UICollectionViewDataSource - cellForItemAt
    private func configurationDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, RandomPhoto> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.url)!
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
            }
        }
        
        // cellForItemAt - dequeueConfiguredReusableCell
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    

}

extension RandomPhotoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        dump(photo)
    }
    
}

extension RandomPhotoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.remove()
        viewModel.insertPhoto(query: searchBar.text!)
    }
}
