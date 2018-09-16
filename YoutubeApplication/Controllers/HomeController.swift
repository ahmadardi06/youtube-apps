 //
//  ViewController.swift
//  YoutubeApplication
//
//  Created by carsworld Indonesia on 13/09/18.
//  Copyright © 2018 Carsworld Indonesia. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    
    func setupDataApi() {
        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataApi()
        
        navigationController?.navigationBar.isTranslucent = false
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        title.text = "  YouTube"
        title.textColor = UIColor.white
        title.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = title
        
        setupMenuBar()
        setupNavBarRight()
        setupCollectionView()
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    let cellId = "cellId"
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
//        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.isPagingEnabled = true
        
        // membatasi untuk scroll bawahnya menu bar atas
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        let colorBg: [UIColor] = [UIColor.blue, UIColor.green, UIColor.yellow , UIColor.brown]
        cell.backgroundColor = colorBg[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let getValueX = scrollView.contentOffset.x
        menuBar.awalHorizontalView?.constant = getValueX / 4
    }
    
    private func setupMenuBar() {
        
        navigationController?.hidesBarsOnSwipe = true
        
        //create view with background red behind menubar 
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupNavBarRight() {
        let navbarImageSearch = UIImage(named: "avatar")?.withRenderingMode(.alwaysOriginal)
        let navbarImageMore = UIImage(named: "discount")?.withRenderingMode(.alwaysOriginal)
        let navbarRightSearch = UIBarButtonItem(image: navbarImageSearch, style: .plain, target: self, action: #selector(self.handleUsers))
        let navbarRightMore = UIBarButtonItem(image: navbarImageMore, style: .plain, target: self, action: #selector(self.handleDiscount))
        navigationItem.rightBarButtonItems = [navbarRightSearch, navbarRightMore]
    }
    
    lazy var setLaunch: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc func handleUsers() {
        setLaunch.showHandleUsers()
    }
 
    @objc func handleDiscount() {
        scrollToViewIndex(menuIndex: 1)
    }
    
    @objc func scrollToViewIndex(menuIndex: Int) {
        print(menuIndex)
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let hasilBagi = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(hasilBagi), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    @objc func showControllerForSetting(setting: Setting) {
        let dummySettings = UIViewController()
        dummySettings.navigationItem.title = setting.name.rawValue
        dummySettings.view.backgroundColor = UIColor.white
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettings, animated: true)

    }
    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return videos?.count ?? 0
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
//
//        cell.video = videos? [indexPath.item]
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.width - 16 - 16) * 9 / 16
//        return CGSize(width: view.frame.width, height: height + 16 + 88)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }

}
