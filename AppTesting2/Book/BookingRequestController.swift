//
//  BookingRequestController.swift
//  AppTesting2
//
//  Created by Sovorn on 10/14/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

let color = UIColor.rgb(red: 234, green: 137, blue: 129)

class BookingRequestController: UIViewController {
    
    let containerView1: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    let containerView2: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let containerView3: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    let containerView4: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let poepleImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "icon_people")
        iv.tintColor = color
        
        return iv
    }()
    
    let locationImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "icon_location")
        iv.tintColor = color
        
        return iv
    }()
    
    let timeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "icon_time")
        iv.tintColor = color
        
        return iv
    }()
    
    let dateImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "icon_date")
        iv.tintColor = color
        
        return iv
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter your name"
        
        return tf
    }()
    
    let countryCode: UITextField = {
        let tf = UITextField()
        tf.placeholder = "  +855"
        tf.isUserInteractionEnabled = false
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
        tf.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
        tf.layer.borderWidth = 1
        
        return tf
    }()
    
    let phoneTextContainer: UIView = {
        let tf = UIView()
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
        tf.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
        tf.layer.borderWidth = 1
        
        return tf
    }()
    
    let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Phone number"
        
        return tf
    }()
    
    let pickLocation: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Pick a location"
        
        return tf
    }()
    
    let timeTextContainer: UIView = {
        let tf = UIView()
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
        tf.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
        tf.layer.borderWidth = 1
        
        return tf
    }()
    
    let dateTextContainer: UIView = {
        let tf = UIView()
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
        tf.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
        tf.layer.borderWidth = 1
        
        return tf
    }()
    
    let timeTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "HH:MM"
        
        return tf
    }()
    
    let dateTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "DD/MM/YY"
        
        return tf
    }()
    
    lazy var bookButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BOOK", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 234, green: 137, blue: 129)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleBookRequest), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleBookRequest(){
        let ac = UIAlertController(title: nil, message: "Comfirm Booking", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            DispatchQueue.main.async {
                let label = UILabel()
                let view = UIView()
                view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                view.backgroundColor = UIColor(white: 0, alpha: 0.3)
                self.view.addSubview(view)
                label.text = "ការកក់រួចរាល់"
                label.textColor = color
                label.font = UIFont.boldSystemFont(ofSize: 20)
                label.numberOfLines = 0
                label.backgroundColor = .white
                label.layer.cornerRadius = 10
                label.layer.masksToBounds = true
                label.textAlignment = .center
                label.frame = CGRect(x: 0, y: 0, width: 160, height: 80)
                label.center = view.center
                self.view.addSubview(label)
                
                label.layer.transform = CATransform3DMakeScale(0, 0, 0)
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    label.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }, completion: { (completed) in
                    UIView.animate(withDuration: 0.5, delay: 0.6, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                        label.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                        label.alpha = 0
                    }, completion: { (_) in
                        view.removeFromSuperview()
                        label.removeFromSuperview()
                        self.navigationController?.popViewController(animated: true)
                    })
                })
                
            }
        }))
        ac.view.tintColor = color
        present(ac, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = color
        let textAttribute = [NSAttributedString.Key.foregroundColor: color]
        navigationController?.navigationBar.titleTextAttributes = textAttribute
        navigationItem.title = "Booking Request"
        let space = (self.navigationController?.navigationBar.frame.maxY)!
        
        setupLayout()
        let stackView = UIStackView(arrangedSubviews: [containerView1, containerView2, containerView3, containerView4])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 8
        view.addSubview(stackView)
        view.addSubview(bookButton)
        stackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: space + 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 160 + 24)
        bookButton.anchor(top: stackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 40)
        
    }
    
    private func setupLayout(){
        containerView1.addSubview(poepleImageView)
        containerView1.addSubview(nameTextField)
        
        poepleImageView.anchor(top: containerView1.topAnchor, left: containerView1.leftAnchor, bottom: containerView1.bottomAnchor, right: nameTextField.leftAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 20, height: 20)
        nameTextField.anchor(top: containerView1.topAnchor, left: poepleImageView.rightAnchor, bottom: containerView1.bottomAnchor, right: containerView1.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        containerView2.addSubview(countryCode)
        containerView2.addSubview(phoneTextContainer)
        phoneTextContainer.addSubview(phoneTextField)
        
        countryCode.anchor(top: containerView2.topAnchor, left: containerView2.leftAnchor, bottom: containerView2.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 0)
        phoneTextContainer.anchor(top: containerView2.topAnchor, left: countryCode.rightAnchor, bottom: containerView2.bottomAnchor, right: containerView2.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        phoneTextField.anchor(top: phoneTextContainer.topAnchor, left: phoneTextContainer.leftAnchor, bottom: phoneTextContainer.bottomAnchor, right: phoneTextContainer.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        containerView3.addSubview(locationImageView)
        containerView3.addSubview(pickLocation)
        
        locationImageView.anchor(top: containerView3.topAnchor, left: containerView3.leftAnchor, bottom: containerView3.bottomAnchor, right: pickLocation.leftAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 20, height: 20)
        pickLocation.anchor(top: containerView3.topAnchor, left: locationImageView.rightAnchor, bottom: containerView3.bottomAnchor, right: containerView3.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        containerView4.addSubview(timeTextContainer)
        containerView4.addSubview(dateTextContainer)
        timeTextContainer.addSubview(timeImageView)
        timeTextContainer.addSubview(timeTextField)
        dateTextContainer.addSubview(dateImageView)
        dateTextContainer.addSubview(dateTextField)
        
        timeTextContainer.anchor(top: containerView4.topAnchor, left: containerView4.leftAnchor, bottom: containerView4.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 0)
        dateTextContainer.anchor(top: containerView4.topAnchor, left: timeTextContainer.rightAnchor, bottom: containerView4.bottomAnchor, right: containerView4.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        timeImageView.anchor(top: timeTextContainer.topAnchor, left: timeTextContainer.leftAnchor, bottom: timeTextContainer.bottomAnchor, right: timeTextField.leftAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 20, height: 20)
        timeTextField.anchor(top: timeTextContainer.topAnchor, left: timeImageView.rightAnchor, bottom: timeTextContainer.bottomAnchor, right: timeTextContainer.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        dateImageView.anchor(top: dateTextContainer.topAnchor, left: dateTextContainer.leftAnchor, bottom: dateTextContainer.bottomAnchor, right: dateTextField.leftAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 20, height: 20)
        dateTextField.anchor(top: dateTextContainer.topAnchor, left: dateImageView.rightAnchor, bottom: dateTextContainer.bottomAnchor, right: dateTextContainer.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        
        
    }
}

