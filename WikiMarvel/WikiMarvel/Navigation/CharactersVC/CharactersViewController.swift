//
//  Test.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 14/02/25.
//

import UIKit

/// Implemented in WMTabBarController
protocol CharactersVCDelegate: AnyObject {
    func loadCharacters(completion: @escaping ([MarvelCharacter]) -> Void)
}

class CharactersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private weak var delegate: CharactersVCDelegate?
    private var charactersList: [MarvelCharacter] = []
    
    static func newInstance(title: String, imageName: String, delegate: CharactersVCDelegate?) -> CharactersViewController{
        let vc = CharactersViewController()
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
        title = "Characters"
        
        loadCharacters()
    }
    
    // MARK: - UICollectionsViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.kReuseIdentifier, for: indexPath) as! CollectionViewCell
        let character = charactersList[indexPath.item]
        cell.configure(title: character.name, url: (character.image?.path ?? "")+"."+(character.image?.urlExtension ?? ""))
        return cell
    }
    
    // MARK: Private Methods
    
    private func loadCharacters(){
        delegate?.loadCharacters() { result in
            self.charactersList = result
            self.collectionView.reloadData()
        }
    }
    
}
