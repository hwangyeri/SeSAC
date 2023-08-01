//
//  BOOKWARMCollectionViewController.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit

class BOOKWARMCollectionViewController: UICollectionViewController {
    
    let user = "yeri"
    var movieInfo = MovieInfo() {
        didSet {
            collectionView.reloadData()
            print("didSet")
        }
    }
    let colorList: [UIColor] = [UIColor.systemIndigo, UIColor.systemPink, UIColor.systemOrange, UIColor.systemMint, UIColor.systemRed, UIColor.systemPurple, UIColor.systemTeal, UIColor.systemBlue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(user) 님의 책장"

        //XIB
        let nib = UINib(nibName: BOOKWARMCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BOOKWARMCollectionViewCell.identifier)
        
        setCollectionViewLayout()
        
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        collectionView.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BOOKWARMCollectionViewCell.identifier, for: indexPath) as! BOOKWARMCollectionViewCell
        let alphaColor = colorList[indexPath.row % colorList.count].withAlphaComponent(0.7)
        let row = movieInfo.movie[indexPath.row]
        
        cell.backView.backgroundColor = alphaColor
        cell.backView.layer.cornerRadius = 20
        
        cell.mainTitleLable.textColor = .white
        cell.mainTitleLable.text = row.title
        cell.mainTitleLable.font = .boldSystemFont(ofSize: 17)
        
        cell.subTitleLable.textColor = .white
        cell.subTitleLable.text = "\(row.rate)"
        cell.subTitleLable.font = .systemFont(ofSize: 10)
        
        cell.posterImageView.image = UIImage(named: "\(row.imageName)")
        
        cell.configureLikeButton(row: row)
        cell.likeButton.setTitle("", for: .normal)
        cell.likeButton.tintColor = .red
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc
    func likeButtonClicked(sender: UIButton) {
        movieInfo.movie[sender.tag].like.toggle()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: DetailViewController.identifier) as! DetailViewController
        let selectedMovie = movieInfo.movie[indexPath.row]
        
        vc.selectedMovie = selectedMovie
        vc.naviTitle = movieInfo.movie[indexPath.row].title
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: SearchViewController.identifier) as! SearchViewController
        let nav = UINavigationController(rootViewController: vc)

        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
}
