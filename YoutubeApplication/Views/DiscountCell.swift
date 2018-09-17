//
//  DiscountCell.swift
//  YoutubeApplication
//
//  Created by carsworld Indonesia on 17/09/18.
//  Copyright © 2018 Carsworld Indonesia. All rights reserved.
//

import UIKit

class DiscountCell: FeedCell {
    
    override func setupDataApi() {
        ApiService.sharedInstance.fetchDiscount { (videos: [Video]) in
            self.videos = videos
            self.colView.reloadData()
        }
    }
    
}
