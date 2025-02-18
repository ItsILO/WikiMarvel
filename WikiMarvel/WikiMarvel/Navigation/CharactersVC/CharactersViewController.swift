//
//  Test.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 14/02/25.
//

import UIKit

class CharactersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let charactersList = [Cell(title: "Iron Man", imageUrl: "https://i.pinimg.com/1200x/da/5a/33/da5a33cc06f4106bbf20e0c68d28eea6.jpg"),
        Cell(title: "Hulk", imageUrl: "https://static.wikia.nocookie.net/heroes-and-villain/images/f/fc/AoU_Hulk_01.png/revision/latest?cb=20181015193439"),
        Cell(title: "Thor", imageUrl: "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/8911a890-1488-4033-b210-287b6a9c5319/dfa8nhb-37ef5c19-c660-46e9-9713-1676aff8d978.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzg5MTFhODkwLTE0ODgtNDAzMy1iMjEwLTI4N2I2YTljNTMxOVwvZGZhOG5oYi0zN2VmNWMxOS1jNjYwLTQ2ZTktOTcxMy0xNjc2YWZmOGQ5NzgucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.N_HypUM84obULaIGSv_YRnFjkokTOga9pu2f0COqLN4"),
        Cell(title: "Captain America", imageUrl:"https://pngfre.com/wp-content/uploads/captain-america-poster.png"),
        Cell(title: "Spiderman", imageUrl:"https://i.pinimg.com/736x/94/0a/fb/940afb4098c012f6d6e725203f1a5ff9.jpg")]
    
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
        title = "Characters"
        
        WMNetworkManager().getComics()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.kReuseIdentifier, for: indexPath) as! CollectionViewCell
        let character = charactersList[indexPath.item]
        cell.configure(title: character.title, url: character.imageUrl)
        return cell
    }
}
