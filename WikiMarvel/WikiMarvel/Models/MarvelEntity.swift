//
//  MarvelEntity.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 21/02/25.
//

import Foundation

protocol MarvelEntity {
    var id: Int { get }
    var name: String { get }
    var description: String? { get }
    var image: MarvelImage? { get }
}
