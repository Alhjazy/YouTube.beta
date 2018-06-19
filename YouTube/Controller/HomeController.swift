//
//  ViewController.swift
//  YouTube
//
//  Created by Ahmad Hjazy on 16/06/2018.
//  Copyright © 2018 Ahmad Hjazy. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController , UICollectionViewDelegateFlowLayout{

//    var videos : [Video] = {
//        var kanyeChannel = Channel()
//        kanyeChannel.name = "KanyeIsTheBastChannel"
//        kanyeChannel.userProfileImage = "kanye_profile"
//
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "Taylor Swift - Blank Space "
//        blankSpaceVideo.thumbnailImageName = "taylor_swift_blank_space"
//        blankSpaceVideo.numberOfViews = 32442343242
//        blankSpaceVideo.channel = kanyeChannel
//
//        var badBloodVideo = Video()
//        badBloodVideo.title = "Taylor Swift - Bad Blood featuring kandrick lamar "
//        badBloodVideo.thumbnailImageName = "taylor_swift_bad_blood"
//        badBloodVideo.numberOfViews = 542232342432
//        badBloodVideo.channel = kanyeChannel
//
//        return [blankSpaceVideo,badBloodVideo]
//    }()
    
    var videos : [Video]?
    
    func featchVideo(){
        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json");        URLSession.shared.dataTask(with: url! as URL){(data, response, error) in
            if error != nil {
                print(error)
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.videos = [Video]()
                for Dictionary in json as! [[String:AnyObject]]{
                    let video = Video()
                    video.title = Dictionary["title"] as! String
                    video.thumbnailImageName = Dictionary["thumbnail_image_name"] as! String
                    let channelDictionary = Dictionary["channel"]
                    
                    let channel = Channel()
                    channel.name = channelDictionary!["name"] as! String
                    channel.userProfileImage = channelDictionary!["profile_image_name"] as! String
                    video.channel = channel
                    
                    self.videos?.append(video)
                }
                
                DispatchQueue.main.async(execute : {self.collectionView?.reloadData()})
                
            }catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featchVideo()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x:0,y:0,width:view.frame.width - 32,height:view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView  = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsets(top: 50,left: 0,bottom: 0,right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50,left: 0,bottom: 0,right: 0)
        
        setuptMenuBar()
        setupNavBarButtons()
    }
    
    func setupNavBarButtons(){
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(didTapSearchButton) )
        let moreBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action:#selector(handelMore) )
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem,searchBarButtonItem]
    }
    
    let settinsLuncher = SettingsLauncher()
    @objc func handelMore(sender: Any){
        settinsLuncher.showSettings()
    }
    @objc func didTapSearchButton(sender: Any){
        print("123")
    }
    
    
    let menuBar:MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    private func setuptMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    // Number of cell at the rows
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
//        if let count = videos?.count{
//            return count
//        }
//
//        return 0
        return videos?.count ?? 0
    }
    //cell detail
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16 ) * 9 / 16
        return CGSize(width:view.frame.width , height:height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}










