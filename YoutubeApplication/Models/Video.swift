//
//  Video.swift
//  YoutubeApplication
//
//  Created by carsworld Indonesia on 14/09/18.
//  Copyright © 2018 Carsworld Indonesia. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImage: String?
    var titleVideo: String?
    var numberViews: NSNumber?
    var createAt: NSDate?
    
    var channel: Channel?
    
}

class Channel: NSObject {
    
    var name: String?
    var imageChannel: String?
    
}
