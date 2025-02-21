//
//  MarvelCharacter.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 21/02/25.
//

import Foundation

struct MarvelCharacter: MarvelEntity, Decodable {
    let id: Int
    let name: String
    let description: String?
    let image: MarvelImage?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case image = "thumbnail"
    }
}
