//
//  WMNetworkManager.swift
//  WikiMarvel
//
//  Created by Ilyas Harram on 18/02/25.
//

import Foundation
import CommonCrypto

class WMNetworkManager {
    private static let kPrivateKey = "8b3a6fbe34713292b51159778a85c461461e5dff"
    private static let kPublicKey = "b1f48980dab5c1c1eb520db63b0cb116"
    
    public func getComics(completion: @escaping (Result<[MarvelComic], Error>) -> Void ) {
        fetchData(type: MarvelType.comics, responseType: MarvelResponse<MarvelComic>.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getSeries(completion: @escaping (Result<[MarvelSeries], Error>) -> Void ) {
        fetchData(type: MarvelType.series, responseType: MarvelResponse<MarvelSeries>.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data.results))
            case .failure(let error):
                completion(.failure(error))
            }}}
    
    func fetchData<T: Decodable>(type: MarvelType, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void ) {
        let url = UrlUtils.getUrl(type: type, ts: getTimestamp(), key: WMNetworkManager.kPublicKey, hash: self.getHash())
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            
            guard error == nil else {
                DispatchQueue.main.async {
                    print(String(data: data!, encoding: .utf8) ?? "No data")
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    print("Statuc code error: \(String(describing: response))")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    print("No Data")
                }
                return
            }
            
            DispatchQueue.main.async {
                print("res: \(String(describing: response))")
                print("data: \(String(describing: data))")
                
                do {
                    let response = try JSONDecoder().decode(responseType, from: data)
                    completion(.success(response))
                } catch {
                    print("Decode problem")
                    completion(.failure(NSError.init(domain: "WikiMarvel.networkManager", code: 400, userInfo: ["reason": "Decode problems"])))
                    return
                }
            }}
            task.resume()
        }
    
    //MARK: - Private Methods
    
    private func getTimestamp() -> String {
        return String(Int64(Date().timeIntervalSince1970))
    }
    
    private func getHash() -> String {
        return getMD5(string: "\(getTimestamp())\(Self.kPrivateKey)\(Self.kPublicKey)")
    }
    
    private func getMD5(string: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using: .utf8)!
        var digest = [UInt8](repeating: 0, count: length)
        _ = messageData.withUnsafeBytes {
            CC_MD5($0.baseAddress!, CC_LONG(messageData.count), &digest)
        }
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    
}
