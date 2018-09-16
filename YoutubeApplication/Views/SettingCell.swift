//
//  SettingCell.swift
//  YoutubeApplication
//
//  Created by carsworld Indonesia on 15/09/18.
//  Copyright © 2018 Carsworld Indonesia. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue 
            
            if let getImg = setting?.icon {
                iconImage.image = UIImage(named: getImg)
            }
        }
    }
    
    var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Setting"
        lbl.font = UIFont.systemFont(ofSize: 13)
        return lbl
    }()
    
    var iconImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "cogs")?.withRenderingMode(.alwaysTemplate)
        img.contentMode = .scaleAspectFill
        img.tintColor = UIColor.darkGray
        return img
    }()
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImage.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImage)
        
        //H is horizontal and V is Vertical
        addConstraintWithFormat(format: "H:|-16-[v0(25)]-10-[v1]|", views: iconImage, nameLabel)
        addConstraintWithFormat(format: "V:|[v0]|", views: nameLabel)
        
        addConstraintWithFormat(format: "V:[v0(25)]", views: iconImage)
        
        //center the icon to mid Y
        addConstraint(NSLayoutConstraint(item: iconImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
