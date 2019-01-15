//
//  CenterViewController.swift
//  AppTesting2
//
//  Created by Sovorn on 10/21/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

protocol LeftDelegate {
    func handleTapContainerLeftView(_ recognizer: UIPanGestureRecognizer)
//    func handleEdgePan(_ recognizer: UIScreenEdgePanGestureRecognizer)
}

class LeftViewController: UIViewController, UIGestureRecognizerDelegate {
    var delegate: LeftDelegate?
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleLeft)))
        return view
    }()
    
    @objc func handleLeft(_ recognizer: UIPanGestureRecognizer){
        delegate?.handleTapContainerLeftView(recognizer)
    }
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "jay")
        iv.backgroundColor = UIColor(white: 0, alpha: 0.1)
        iv.layer.cornerRadius = 100 / 2
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 3
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = "Sovorn"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        
        return label
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleLogout(){
        let ac = UIAlertController()
        ac.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            do {
                try Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "login")
                UserDefaults.standard.synchronize()
                let loginController = UINavigationController(rootViewController: LoginController())
                self.present(loginController, animated: true)
            } catch let singOut {
                print("Error sign out", singOut)
            }
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    lazy var solonButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Salon", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleSalon), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleSalon(){
        let loginController = UINavigationController(rootViewController: SalonController())
        self.present(loginController, animated: true)
    }
    
    let edgePan = UIScreenEdgePanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        view.backgroundColor = .mainColor()
        view.addSubview(profileImageView)
        view.addSubview(userName)
        view.addSubview(welcomeLabel)
        view.addSubview(logoutButton)
        view.addSubview(solonButton)
        
//        edgePan.addTarget(self, action: #selector(screenEdgeSwiped))
//        edgePan.edges = .right
//        view.addGestureRecognizer(edgePan)
        
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 250, height: 0)
        
        profileImageView.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: userName.leftAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 100, height: 100)
        userName.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: containerView.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 100, height: 30)
        welcomeLabel.anchor(top: profileImageView.topAnchor, left: userName.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 80, height: 20)
        
        solonButton.anchor(top: profileImageView.bottomAnchor, left: profileImageView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 50, height: 40)
        
        logoutButton.anchor(top: nil, left: profileImageView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 30, paddingRight: 0, width: 60, height: 40)
    }
    
//    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer){
//        delegate?.handleEdgePan(recognizer)
//    }
}
