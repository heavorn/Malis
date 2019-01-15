//
//  CustomImageView.swift
//  AppTesting2
//
//  Created by Sovorn on 10/13/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastUrlUseToLoadImage: String?
    
    func loadImage(urlString: String) {
        lastUrlUseToLoadImage = urlString
        
        self.image = nil
        
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (error != nil) {
                print("Failed to fetch post image:", error!)
            }
            
            if  url.absoluteString != self.lastUrlUseToLoadImage {return}
            
            DispatchQueue.main.async {
                if let downloadImage = UIImage(data: data!) {
                    imageCache[url.absoluteString] = downloadImage
                    self.image = downloadImage
                }
            }
            }.resume()
    }
}
