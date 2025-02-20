//
//  MarvelResponse.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 20/02/25.
//

import Foundation

struct MarvelResponse<T: Decodable>: Decodable {
    let status: String
    let copyright: String
    let attributionText: String
    let data: MarvelPage<T>
}

struct MarvelPage<T: Decodable>: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let results: [T]
}

struct MarvelSeries: Decodable {
    let id: Int
    let name: String
    let description: String?
    let image: MarvelImage?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case description
        case image = "thumbnail"
    }
}

struct MarvelComic: Decodable {
    let id: Int
    let name: String
    let description: String?
    let image: MarvelImage?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case description
        case image = "thumbnail"
    }
}

struct MarvelImage: Decodable {
    let path: String
    let urlExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case urlExtension = "extension"
    }
}

