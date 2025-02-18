//
//  Test.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 14/02/25.
//

import UIKit

class ComicsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let comicsList = [Cell(title: "Capitan America", imageUrl: "https://www.panini.it/media/catalog/product/cache/ed7120e12c05c4607bf8f8318289dd0a/M/F/MFRST160ISBN_0.jpg"),
        Cell(title: "Spider-Man", imageUrl: "https://www.panini.it/media/catalog/product/cache/ed7120e12c05c4607bf8f8318289dd0a/M/A/MABRA004ISBN_0.jpg"),
        Cell(title: "X-Men", imageUrl: "https://www.panini.it/media/catalog/product/cache/ed7120e12c05c4607bf8f8318289dd0a/M/G/MGIXM422_0.jpg"),
        Cell(title: "Wolverine", imageUrl:"https://www.panini.it/media/catalog/product/cache/ed7120e12c05c4607bf8f8318289dd0a/M/W/MWOLV457ISBN_0.jpg"),
        Cell(title: "XForce", imageUrl:"https://www.panini.it/media/catalog/product/cache/ed7120e12c05c4607bf8f8318289dd0a/M/X/MXFOC055ISBN_0.jpg")]
    
    static func newInstance(title: String, imageName: String) -> ComicsViewController{
        let vc = ComicsViewController()
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
        title = "Comics"
    }

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return comicsList.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.kReuseIdentifier, for: indexPath) as! CollectionViewCell
    let comic = comicsList[indexPath.item]
    cell.configure(title: comic.title, url: comic.imageUrl)
    return cell
}

}
