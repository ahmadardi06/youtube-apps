//
//  SettingsLauncher.swift
//  YoutubeApplication
//
//  Created by carsworld Indonesia on 15/09/18.
//  Copyright © 2018 Carsworld Indonesia. All rights reserved.
//

import UIKit

class Setting: NSObject {
    
    let name: SettingName
    let icon: String
    
    init(name: SettingName, icon: String) {
        self.name = name
        self.icon = icon
    }
}

enum SettingName: String {
    case Cancel  = "Cancel & Dismiss  "
    case SwitchAccount = "Switch Account"
    case Setting = "Setting"
    case TermPolicy = "Term & Privacy Policy"
    case ShareVideo = "Share Video"
    case Help = "Help"
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    var homeController: HomeController?
    
    let settings: [Setting] = {
        return [
            Setting(name: .SwitchAccount, icon: "switch-account"),
            Setting(name: .Setting, icon: "cogs"),
            Setting(name: .TermPolicy, icon: "padlock"),
            Setting(name: .ShareVideo, icon: "share"),
            Setting(name: .Help, icon: "info"),
            Setting(name: .Cancel, icon: "error")
        ]
    }()
    
    @objc func showHandleUsers() {
        //klik users left top menu
        if let wind = UIApplication.shared.keyWindow {
            
            wind.addSubview(blackView)
            wind.addSubview(collectionView)
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleDismiss)))
            blackView.frame = wind.frame
            blackView.alpha = 0
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight 
            let valueY = wind.frame.height - height
            collectionView.frame = CGRect(x: 0, y: wind.frame.height, width: wind.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: valueY, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
        }
    }
    
    @objc func handleDismiss(setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            
            if let wind = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: wind.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height )
            }
            
        }) { (completed: Bool) in
            if setting.name != .Cancel {
                self.homeController?.showControllerForSetting(setting: setting)
            }
        }
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        handleDismiss(setting: setting)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        
        let sett = settings[indexPath.item]
        cell.setting = sett
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
     
}
