//
//  SafeJsonObject.swift
//  YoutubeApplication
//
//  Created by carsworld Indonesia on 17/09/18.
//  Copyright © 2018 Carsworld Indonesia. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject {

    override func setValue(_ value: Any?, forKey key: String) {
        let uppercasedFirstCharacter = String(key.first!).uppercased()
        let range = key.startIndex...key.index(key.startIndex, offsetBy: 0)
        let selectorString = key.replacingCharacters(in: range, with: uppercasedFirstCharacter)
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if !responds {
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
}
