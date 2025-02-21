//
//  MarvelImage.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 21/02/25.
//

import Foundation

struct MarvelImage: Decodable {
    let path: String
    let urlExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case urlExtension = "extension"
    }
}
