//
//  VideoCell.swift
//  YouTube
//
//  Created by Ahmad Hjazy on 16/06/2018.
//  Copyright © 2018 Ahmad Hjazy. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class VideoCell:BaseCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        super.setupViews()
    }
    
    
    var video : Video? {
        didSet{
            titleLabel.text = video?.title
            //load the image form the url
            setupThumbnailImage()
            setupProfileImage()
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle  = .decimal
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews{
                let subTitleText = "\(channelName) - \(numberFormatter.string(from: numberOfViews)!) views - 2 years ago"
                subTitleTextView.text = subTitleText
            }
            
            //mesure title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font:  UIFont(name: "Helvetica-Bold", size: 15.0)!], context: nil)
                
                if estimatedRect.size.height > 20{
                    titleLabelHeightConstraints?.constant = 44
                }else{
                    titleLabelHeightConstraints?.constant = 20
                }
            }
        }
    }
   
    func setupProfileImage() {
        
        if let ProfileImageUrl = video?.channel?.userProfileImage {
            userProfileImageView.loadImageUsingUrlString(urlString: ProfileImageUrl)
        }
    }
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
            thumbinalImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    let thumbinalImageView : CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "tylor_swift_clip1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView : CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "user_profile_1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let supratorView : UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/250, green: 230/255, blue: 230/250, alpha: 1)
        return view
    }()
    
    let titleLabel : UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tylor Swift - Blank Space"
        label.numberOfLines = 2
        return label
    }()
    
    let subTitleTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Tylor SwiftVEVO ☻ 1,666,455 views ☻ 2 years ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -0, 0, 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    var titleLabelHeightConstraints : NSLayoutConstraint?
    
    override func setupViews(){
        addSubview(thumbinalImageView)
        thumbinalImageView.frame = CGRect.init(x:0,y:0,width:100,height:100)
        addSubview(supratorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleTextView)
        
        //contraints
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views:  thumbinalImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]-|", views:  userProfileImageView)
        
        //vertical contraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views:  thumbinalImageView,userProfileImageView,supratorView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: supratorView)
        
        //top constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbinalImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbinalImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraints
        titleLabelHeightConstraints = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstraints!)
        
        //top constraints
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left constraints
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraints
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbinalImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraints
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 26))
        
        //addConstraintsWithFormat(format: "V:|[v0(20)]|", views: titleLabel)
        //addConstraintsWithFormat(format: "H:|v0|", views: titleLabel)
}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
