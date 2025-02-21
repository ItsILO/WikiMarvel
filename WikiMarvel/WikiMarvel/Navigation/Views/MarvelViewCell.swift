//
//  CollectionViewCell.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 13/02/25.
//

import UIKit
import SDWebImage

class MarvelViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    public static let kReuseIdentifier: String = "MarvelViewCell"
    
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
    
    func configure(title: String, url: String) {
        titleLabel.text = title
        imageView.sd_setImage(with: URL(string: url))
    }

}
