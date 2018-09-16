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
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
         
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var videos = [Video]()
                
                for item in json as! [[String: AnyObject]] {
                    
                    let vid = Video()
                    vid.titleVideo = item["title"] as? String
                    vid.thumbnailImage = item["thumbnail_image_name"] as? String
                    vid.numberViews = item["number_of_views"] as? NSNumber
                    
                    let chnItem = item["channel"] as! [String: AnyObject]
                    
                    let chn = Channel()
                    chn.name = chnItem["name"] as? String
                    chn.imageChannel = chnItem["profile_image_name"] as? String
                    
                    vid.channel = chn
                    
                    videos.append(vid)
                }
                
                DispatchQueue.main.async {
                    completion(videos) 
                }
                
            } catch let errJson {
                print(errJson)
            }
            
        }).resume()
    }
}
