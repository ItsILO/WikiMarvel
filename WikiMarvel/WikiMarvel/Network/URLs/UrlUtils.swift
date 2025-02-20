//
//  UrlUtils.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 19/02/25.
//

import Foundation

struct UrlUtils {
    
    static let baseUrl = "https://gateway.marvel.com/v1/public/"
    
    
    static func getUrl(type: MarvelType, ts: String, key: String, hash: String) -> URL {
        let typeString: String
        switch type {
        case .comics:
            typeString = MarvelType.comics.rawValue
        case .characters:
            typeString = MarvelType.characters.rawValue
        case .series:
            typeString = MarvelType.series.rawValue
        }
        let url = baseUrl + typeString + "?ts=\(ts)&apikey=\(key)&hash=\(hash)"
        return URL(string: url) ?? URL(string: "")!
    }
    
}
