//
//  WMTabBarController.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 19/02/25.
//

import UIKit

class WMTabBarController: UITabBarController, ComicsVCDelegate, SeriesVCDelegate, CharactersVCDelegate {
    
    private weak var networkManager: WMNetworkManager!
    
    static func newInstance(networkManager: WMNetworkManager) -> WMTabBarController {
        let tabBarController = WMTabBarController()
        tabBarController.networkManager = networkManager
        
        let charactersVC = CharactersViewController.newInstance(title: "Characters", imageName: "person.3.fill", delegate: tabBarController)
        let comicsVC = ComicsViewController.newInstance(title: "Comics", imageName: "book.fill", delegate: tabBarController)
        let seriesVC = SeriesViewController.newInstance(title: "Series", imageName: "tv.fill", delegate: tabBarController)
        let charactersNavController = UINavigationController(rootViewController: charactersVC)
        let comicsNavController = UINavigationController(rootViewController: comicsVC)
        let seriesNavController = UINavigationController(rootViewController: seriesVC)
       
        tabBarController.viewControllers = [charactersNavController, comicsNavController, seriesNavController]
        
        return tabBarController
    }
    
    // MARK: - ComicsVCDelegate
    
    func loadComics(completion: @escaping ([MarvelComic]) -> Void) {
        networkManager.getComics() { result in
                switch result {
                    case .success(let comics):
                        completion(comics)
                    case .failure(let error):
                        print("Error: \(error)")
                }
        }
    }
    
    // MARK: - SeriesVCDelegate
    
    func loadSeries(completion: @escaping ([MarvelSeries]) -> Void) {
        networkManager.getSeries() { result in
                switch result {
                    case .success(let series):
                        completion(series)
                    case .failure(let error):
                        print("Error: \(error)")
                }
        }
    }
    
    // MARK: - CharactersVCDelegate
    
    func loadCharacters(completion: @escaping ([MarvelCharacter]) -> Void) {
        networkManager.getCharacters() { result in
                switch result {
                    case .success(let series):
                        completion(series)
                    case .failure(let error):
                        print("Error: \(error)")
                }
        }
    }
    
}
