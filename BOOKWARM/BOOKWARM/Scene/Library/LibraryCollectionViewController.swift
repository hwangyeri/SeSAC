//
//  BOOKWARMCollectionViewController.swift
//  BOOKWARM
//
//  Created by 황예리 on 2023/07/31.
//

import UIKit
import RealmSwift

class LibraryCollectionViewController: UICollectionViewController {
    
//    var movieInfo = MovieInfo() {
//        didSet {
//            collectionView.reloadData()
//            print("didSet")
//        }
//    }
    
    var tasks: Results<BookTable>!
    let realm = try! Realm()
    
    var bookList: Book = Book(documents: [], meta: Meta(isEnd: false))
    
    let colorList: [UIColor] = [UIColor.systemIndigo, UIColor.systemPink, UIColor.systemOrange, UIColor.systemMint, UIColor.systemRed, UIColor.systemPurple, UIColor.systemTeal, UIColor.systemBlue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Realm Read // 데이터 가져오기
        print(realm.configuration.fileURL ?? "fileURL print Error")
        
        // 내용 추가시, 제목순으로 정렬, 내림차순 true
        tasks = realm.objects(BookTable.self).sorted(byKeyPath: "bookTitle", ascending: false)

        //XIB
        let nib = UINib(nibName: LibraryCollectionViewCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: LibraryCollectionViewCell.reuseIdentifier)
        
        setCollectionViewLayout()
        
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
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
        return tasks.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.reuseIdentifier, for: indexPath) as! LibraryCollectionViewCell
        let alphaColor = colorList[indexPath.row % colorList.count].withAlphaComponent(0.7)
        let data = tasks[indexPath.row]
        
        cell.backView.backgroundColor = alphaColor
        cell.mainTitleLable.text = data.bookTitle
        cell.subTitleLable.text = "\(data.bookAuthors)"
        cell.posterImageView.image = loadImageFromDocument(fileName: "yeri_\(data._id).jpg")
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc
    func likeButtonClicked(sender: UIButton) {
//        tasks[sender.tag].bookLiked.toggle()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: DetailViewController.reuseIdentifier) as! DetailViewController
//        let selectedBook = tasks[indexPath.row]
        let data = tasks[indexPath.row]
        
        vc.selectedBook = data
        vc.naviTitle = data.bookTitle
        vc.hidesBottomBarWhenPushed = true // Tab Bar Hide
        
        navigationController?.pushViewController(vc, animated: false)
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(identifier: MySearchViewController.reuseIdentifier) as! MySearchViewController
        let nav = UINavigationController(rootViewController: vc)

        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
}
