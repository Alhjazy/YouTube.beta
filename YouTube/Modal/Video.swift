//
//  Video.swift
//  YouTube
//
//  Created by Ahmad Hjazy on 17/06/2018.
//  Copyright © 2018 Ahmad Hjazy. All rights reserved.
//

import UIKit

class Video : NSObject{
    var thumbnailImageName : String?
    var title : String?
    var numberOfViews : NSNumber?
    var uploadDate : NSDate?
    var channel : Channel?
}

class Channel : NSObject{
    var name : String?
    var userProfileImage : String?
}













