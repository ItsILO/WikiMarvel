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
    
    private static let kBaseUrlString = "http://gateway.marvel.com/v1/public"
    private static let kTs = ""
    
    public func getComics() {
        let task = URLSession.shared.dataTask(with: URL(string: "\(Self.kBaseUrlString)/comics?ts=\(getTimestamp())&apikey=\(Self.kPublicKey)&hash=\(getHash())")!) {
            data, response, error in
        
            
            guard error != nil else {
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
                print(String(data: data, encoding: .utf8) ?? "No data")
            }
        }
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
