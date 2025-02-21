//
//  MarvelContentVC.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 21/02/25.
//

import UIKit

protocol MarvelContentVCDelegate: AnyObject {
    func loadMarvelContent(type: MarvelType , completion: @escaping ([MarvelEntity]) -> Void)
}

class MarvelContentVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private weak var delegate: MarvelContentVCDelegate?
    private var marvelList: [MarvelEntity] = []
    private var marvelContentType: MarvelType?

    
    static func newInstance(title: String, imageName: String, delegate: MarvelContentVCDelegate?, type: MarvelType) -> MarvelContentVC{
        let vc = MarvelContentVC()
        vc.title = title
        vc.tabBarItem.image = UIImage(systemName: imageName)
        vc.delegate = delegate
        vc.marvelContentType = type
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(MarvelViewCell.nib(), forCellWithReuseIdentifier: MarvelViewCell.kReuseIdentifier)
        
        loadData()
    }
    
    // MARK: - UICollectionsViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marvelList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarvelViewCell.kReuseIdentifier, for: indexPath) as! MarvelViewCell
        let marvel = marvelList[indexPath.item]
        cell.configure(title: marvel.name, url: (marvel.image?.path ?? "")+"."+(marvel.image?.urlExtension ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let cellCount = CGFloat(marvelList.count)

        if cellCount > 0 {
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidth = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing

            let totalCellWidth = cellWidth*cellCount + 20.00 * (cellCount-1)
            let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right

            if (totalCellWidth < contentWidth) {
                let padding = (contentWidth - totalCellWidth) / 2.0
                return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
            } else {
                return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
            }
        }
        return UIEdgeInsets.zero
    }
    
    // MARK: - Private Methods
    
    private func loadData() {
        delegate?.loadMarvelContent(type: marvelContentType ?? .characters) { result in
            self.marvelList = result
            self.collectionView.reloadData()
        }
    }

}
