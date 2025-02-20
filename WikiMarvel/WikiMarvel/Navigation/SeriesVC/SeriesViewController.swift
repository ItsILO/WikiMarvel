//
//  Test.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 14/02/25.
//

import UIKit

/// Implemented in WMTabBarController
protocol SeriesVCDelegate: AnyObject {
    func loadSeries(completion: @escaping ([MarvelSeries]) -> Void)
}

class SeriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private weak var delegate: SeriesVCDelegate?
    private var seriesList: [MarvelSeries] = []
    
    static func newInstance(title: String, imageName: String, delegate: SeriesVCDelegate?) -> SeriesViewController{
        let vc = SeriesViewController()
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
        title = "Series"
        
        loadSeries()
    }

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return seriesList.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.kReuseIdentifier, for: indexPath) as! CollectionViewCell
    let series = seriesList[indexPath.item]
    cell.configure(title: series.name, url: (series.image?.path ?? "")+"."+(series.image?.urlExtension ?? ""))
    return cell
}
    
// MARK: - Private Methods
    
    private func loadSeries() {
        delegate?.loadSeries() { result in
            self.seriesList = result
            self.collectionView.reloadData()
        }
    }

}
