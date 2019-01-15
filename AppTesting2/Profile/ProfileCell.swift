//
//  ProfileCell.swift
//  AppTesting2
//
//  Created by Sovorn on 10/14/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

protocol ProfileCellDelegate {
    func performZoomForImageView(imageView: UIImageView)
}

class ProfileCell: UICollectionViewCell {
    
    var delegate: ProfileCellDelegate?
    
    let photo: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .lightGray
        iv.backgroundColor = UIColor(white: 0, alpha: 0.3)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    @objc func handleZoom(tapGesture: UITapGestureRecognizer){
        self.delegate?.performZoomForImageView(imageView: self.photo)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(photo)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoom)))
        photo.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
