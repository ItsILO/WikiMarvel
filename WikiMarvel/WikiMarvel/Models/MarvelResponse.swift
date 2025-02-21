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


