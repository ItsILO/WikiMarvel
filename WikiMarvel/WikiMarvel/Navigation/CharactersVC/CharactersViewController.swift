//
//  Test.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 14/02/25.
//

import UIKit

class CharactersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static func newInstance(title: String, imageName: String) -> CharactersViewController{
        let vc = CharactersViewController()
        vc.title = title
        vc.tabBarItem.image = UIImage(systemName: imageName)
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
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.kReuseIdentifier, for: indexPath) as! CollectionViewCell
            return cell
    }
}
