//
//  TrendingCell.swift
//  YoutubeApplication
//
//  Created by carsworld Indonesia on 17/09/18.
//  Copyright © 2018 Carsworld Indonesia. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func setupDataApi() {
        ApiService.sharedInstance.fetchTrending { (videos: [Video]) in
            self.videos = videos
            self.colView.reloadData()
        }
    }
    
}
