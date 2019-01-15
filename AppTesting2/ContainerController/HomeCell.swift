//
//  HomeCell.swift
//  AppTesting2
//
//  Created by Sovorn on 10/13/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

protocol HomeCellDelegate {
    func handleBookButton(for cell: HomeCell)
}

class HomeCell: UICollectionViewCell {
    
    var delagate: HomeCellDelegate?
    
    var salon: Salon? {
        didSet {
            guard let profileUrl = salon?.profileUrl, let name = salon?.name, let price = salon?.price, let discount = salon?.discount, let service = salon?.service else {return}
            profileImageView.loadImage(urlString: profileUrl)
            let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 5)]))
            attributedText.append(NSAttributedString(string: "Discount: \(discount)%", attributes: [NSAttributedString.Key.font
                : UIFont.systemFont(ofSize: 13)]))
            attributedText.append(NSAttributedString(string: "\nService: \(service)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)]))
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 5)]))
            attributedText.append(NSAttributedString(string: "Price: $\(price)", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 234, green: 137, blue: 129)]))
            textView.attributedText = attributedText
        }
    }
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.image = UIImage(named: "jay")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.isScrollEnabled = false
        tv.backgroundColor = .clear
        tv.isEditable = false
        
        return tv
    }()
    
    lazy var bookButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BOOK NOW", for: .normal)
        button.titleLabel?.font = UIFont(name: "Noteworthy-Light", size: 14)
        button.setTitleColor(UIColor.rgb(red: 234, green: 137, blue: 129), for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.rgb(red: 234, green: 137, blue: 129).cgColor
        button.layer.borderWidth = 1.5
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleToProfile), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleToProfile(){
        print("Book")
        delagate?.handleBookButton(for: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        backgroundView = nil
        addSubview(profileImageView)
        addSubview(textView)
        addSubview(bookButton)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 0, width: 100, height: 100)
        textView.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: bookButton.leftAnchor, paddingTop: 14, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        bookButton.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 16, paddingRight: 20, width: 80, height: 30)
        
        let separateLine = UIView()
        separateLine.backgroundColor = UIColor(white: 0, alpha: 0.2)
        addSubview(separateLine)
        separateLine.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
