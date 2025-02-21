//
//  Type.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 19/02/25.
//


enum MarvelType: String, Codable {
    case characters
    case comics
    case series
    
    var typeObject: MarvelEntity.Type {
        switch self {
        case .characters: return MarvelCharacter.self
        case .comics: return MarvelComic.self
        case .series: return MarvelSeries.self
        }
    }
}
