//
//  ProfileHeader.swift
//  AppTesting2
//
//  Created by Sovorn on 10/14/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class ProfileHeader: UICollectionViewCell{
    
    var des: String? {
        didSet{
            let attributedText = NSMutableAttributedString(string: "Description", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
            attributedText.append(NSAttributedString(string: "\n\(des!)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
            attributedText.append(NSAttributedString(string: "\nPhotos & Experience", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]))
            desText.attributedText = attributedText
        }
    }
    
    let desText: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isScrollEnabled = false
        
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(desText)
        desText.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 130)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
