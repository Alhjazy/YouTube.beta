//
//  extensions.swift
//  YouTube
//
//  Created by Ahmad Hjazy on 16/06/2018.
//  Copyright © 2018 Ahmad Hjazy. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}


extension UIView{
    func addConstraintsWithFormat(format:String,views:UIView...){
        var viewsDictionary = [String : UIView]()
        for(index,view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:format , options: [], metrics: nil, views: viewsDictionary))
    }
}



let imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageView : UIImageView {
    
    var imageUrlString : String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = NSURL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url! as URL){(data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute : {
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString{
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!,forKey:urlString as AnyObject)
                
                
            })
            
        }.resume()
    }
    
}