 //
//  VideoCell.swift
//  YoutubeApplication
//
//  Created by carsworld Indonesia on 13/09/18.
//  Copyright © 2018 Carsworld Indonesia. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            titleVideo.text = video?.titleVideo
            
            setupThumbnailImage()
            
            setupImageChannel()
            
            if let chName = video?.channel?.name, let nmViews = video?.numberViews {
                let numFormater = NumberFormatter()
                numFormater.numberStyle = .decimal
                
                if let decimalViews = numFormater.string(from: nmViews) {
                    let subTitle = "\(chName) - \(decimalViews) - \(String(describing: video?.createAt))"
                    descVideo.text = subTitle
                }
            }
            
            //measure the title
            if let titVideo = video?.titleVideo {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimate = NSString(string: titVideo).boundingRect(with: size, options: option, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimate.size.height > 20 {
                    labelHeightTitle?.constant = 44
                } else {
                    labelHeightTitle?.constant = 20
                }
            }
        }
    }
    
    func setupThumbnailImage() {
        if let imgURl = video?.thumbnailImage {
            thumbnailImageView.loadImageFromUrl(urlString: imgURl )
        }
    }
    
    func setupImageChannel() {
        if let imgUrl = video?.channel?.imageChannel {
            userProfile.loadImageFromUrl(urlString: imgUrl)
        }
    }
    
    var thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "cardi-b")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfile: CustomImageView = {
        let user = CustomImageView()
        user.image = UIImage(named: "user")
        user.layer.cornerRadius = 22
        user.layer.masksToBounds = true
        user.contentMode = .scaleAspectFill
        return user
    }()
    
    var titleVideo: UILabel = {
        let judul = UILabel()
        judul.text = "Cardi B. I Like It ft. Maroon 5"
        judul.translatesAutoresizingMaskIntoConstraints = false
        judul.numberOfLines = 2
        return judul
    }()
    
    let descVideo: UITextView = {
        let judul = UITextView()
        judul.text = "CardiB.VEVO - 1,550,342 views - 1 months ago"
        judul.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        judul.translatesAutoresizingMaskIntoConstraints = false
        judul.textColor = UIColor.lightGray
        return judul
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    var labelHeightTitle: NSLayoutConstraint?
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfile)
        addSubview(titleVideo)
        addSubview(descVideo)
        
        addConstraintWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        addConstraintWithFormat(format: "H:|-16-[v0(44)]|", views: userProfile)
        
        //vertical constraint
        addConstraintWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfile, separatorView)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: separatorView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleVideo, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleVideo, attribute: .left, relatedBy: .equal, toItem: userProfile, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleVideo, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint 
        labelHeightTitle = NSLayoutConstraint(item: titleVideo, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(labelHeightTitle!)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: descVideo, attribute: .top, relatedBy: .equal, toItem: titleVideo, attribute: .bottom, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: descVideo, attribute: .left, relatedBy: .equal, toItem: userProfile, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: descVideo, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: descVideo, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
}

