//
//  Test.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 14/02/25.
//

import UIKit

/// Implemented in WMTabBarController
protocol ComicsVCDelegate: AnyObject {
    func loadComics(completion: @escaping ([MarvelComic]) -> Void)
}

class ComicsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private weak var delegate: ComicsVCDelegate?
    private var comicsList: [MarvelComic] = []
    
    
    static func newInstance(title: String, imageName: String, delegate: ComicsVCDelegate?) -> ComicsViewController{
        let vc = ComicsViewController()
        vc.title = title
        vc.tabBarItem.image = UIImage(systemName: imageName)
        vc.delegate = delegate
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            CollectionViewCell.nib(),
            forCellWithReuseIdentifier: CollectionViewCell.kReuseIdentifier
        )
        title = "Comics"
        
        loadComics()
    }

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return comicsList.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.kReuseIdentifier, for: indexPath) as! CollectionViewCell
    let comics = comicsList[indexPath.item]
    cell.configure(title: comics.name, url: (comics.image?.path ?? "")+"."+(comics.image?.urlExtension ?? ""))
    return cell
}
    
    // MARK: Private Methods
    
    private func loadComics(){
        delegate?.loadComics() { result in
            self.comicsList = result
            self.collectionView.reloadData()
        }
    }

}
