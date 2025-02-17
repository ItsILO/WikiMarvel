//
//  CollectionViewCell.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 13/02/25.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    public static let kReuseIdentifier: String = "CollectionViewCell"
    
    public static func nib() -> UINib {
        UINib(nibName: Self.kReuseIdentifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }

}
