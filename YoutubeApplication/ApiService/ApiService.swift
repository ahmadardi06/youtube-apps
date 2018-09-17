//
//  ApiService.swift
//  YoutubeApplication
//
//  Created by carsworld Indonesia on 15/09/18.
//  Copyright © 2018 Carsworld Indonesia. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets/"
    
    func fetchFromUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            do {
                if let unwrappedData = data, let itemDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject ]] {
                    
                    let videoss = itemDictionaries.map({ (item) in
                        return Video(dictionary: item)
                    })
                    
                    DispatchQueue.main.async {
                        completion(videoss )
                    }
                    
                }
                
            } catch let errJson {
                print(errJson)
            }
            
        }).resume()
    }
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        
//        let stringUrl = "home.json"
        let stringUrl = "home_num_likes.json"
        fetchFromUrlString(urlString: baseUrl+stringUrl) { (videos) in
            completion(videos)
        }
        
    }
    
    func fetchTrending(completion: @escaping ([Video]) -> ()) {
        
        let stringUrl = "trending.json"
        fetchFromUrlString(urlString: baseUrl+stringUrl) { (videos) in
            completion(videos)
        }
    }
    
    func fetchDiscount(completion: @escaping ([Video]) -> ()) {
        
        let stringUrl = "subscriptions.json"
        fetchFromUrlString(urlString: baseUrl+stringUrl) { (videos) in
            completion(videos)
        }
        
    }
}
