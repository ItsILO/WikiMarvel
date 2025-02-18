//
//  Test.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 14/02/25.
//

import UIKit

class SeriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let seriesList = [Cell(title: "Agents of S.H.I.E.L.D", imageUrl: "https://m.media-amazon.com/images/I/71bTc9F1q+L._AC_UF1000,1000_QL80_.jpg"),
        Cell(title: "Agent Carter", imageUrl: "https://m.media-amazon.com/images/I/81mZ4lAXvOL.jpg"),
        Cell(title: "Inhumans", imageUrl: "https://www.serialminds.com/wp-content/uploads/2017/10/Marvel-Inhumans-6.jpg"),
        Cell(title: "Daredevil", imageUrl:"https://resizing.flixster.com/Czf_CJ4GvM7tF686shrK7KAbJHQ=/fit-in/352x330/v2/https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p11408531_i_v9_aa.jpg"),
        Cell(title: "Jessica Jones", imageUrl:"https://m.media-amazon.com/images/S/pv-target-images/8b6bbc9dd9e97bca6e7d979020ab8b6ce24e044bc0c434025d69d023b3c429b2.jpg")]
    
    static func newInstance(title: String, imageName: String) -> SeriesViewController{
        let vc = SeriesViewController()
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
        title = "Series"
    }

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return seriesList.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.kReuseIdentifier, for: indexPath) as! CollectionViewCell
    let serie = seriesList[indexPath.item]
    cell.configure(title: serie.title, url: serie.imageUrl)
    return cell
}

}
