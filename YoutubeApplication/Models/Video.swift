//
//  Video.swift
//  YoutubeApplication
//
//  Created by carsworld Indonesia on 14/09/18.
//  Copyright © 2018 Carsworld Indonesia. All rights reserved.
//

import UIKit

class Video: SafeJsonObject {
    
    // must be add @objc in your dictionary
    @objc var title: String?
    @objc var number_of_views: NSNumber?
    @objc var thumbnail_image_name: String?
    @objc var duration: NSNumber?
    @objc var channel: Channel?
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "channel" {
            
            //get value from object channel
            let chnItem = value as! [String: AnyObject]
            
            //custom set channel other class
            self.channel = Channel()
            self.channel?.setValuesForKeys(chnItem)
            
        } else {
            super.setValue(value, forKey: key)
        }
    }
}

class Channel: SafeJsonObject  {
    
    @objc var name: String?
    @objc var profile_image_name: String?
    
}
