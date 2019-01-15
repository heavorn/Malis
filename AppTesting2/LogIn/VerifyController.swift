//
//  VerifyController.swift
//  AppTesting2
//
//  Created by Sovorn on 10/19/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

class VerifyController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainColor()
        navigationController?.navigationBar.isHidden = true
        self.hideKeyBoardWhenTappedAround()
        
        setupLayer()
    }
    
    var verifyID: String?
    var name: String?
    var phone: String?
    var passWord: String?
    
    private func setupLayer(){
        view.addSubview(containerView)
        containerView.addSubview(verifyTextField)
        view.addSubview(backButton)
        view.addSubview(verifyButton)
        view.addSubview(invalidLabel)
        
        containerView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 50)
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        invalidLabel.anchor(top: containerView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 15)
        
        verifyTextField.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        backButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 40)
        
        verifyButton.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 80, height: 40)
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let verifyTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Verify code"
        tf.keyboardType = UIKeyboardType.numberPad
        
        return tf
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.tintColor = .mainColor()
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleBack(){
        navigationController?.popViewController(animated: true)
    }
    
    let verifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Verify", for: .normal)
        button.tintColor = .mainColor()
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleVerify), for: .touchUpInside)
        
        return button
    }()
    
    let invalidLabel: UILabel = {
        let label = UILabel()
        label.text = "Verify code is not correct!"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.isHidden = true
        
        return label
    }()
    
    @objc func handleVerify(){	
        self.invalidLabel.isHidden = true
//        guard let verifyCode = UserDefaults.standard.string(forKey: "authVID") else {return}
        guard let verifyCode = verifyID, let username = name, let phone = phone, let password = passWord else {return}
        
        let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: verifyCode, verificationCode: verifyTextField.text!)
//        UserDefaults.standard.set(credential, forKey: "credentialCode")
//        UserDefaults.standard.synchronize()
        Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
            if let err = error {
                self.invalidLabel.isHidden = false
                print("Failed to sign in", err)
                return
            }
            
            
            let values = ["name": username, "phone": phone, "password": password]
            Database.database().reference().child("users").child(phone).updateChildValues(values, withCompletionBlock: { (error, ref) in
                if (error != nil){
                    print("Failed to upload to database", error!)
                    return
                }
                guard let containerController = UIApplication.shared.keyWindow?.rootViewController as? ContainerViewController else {return}
                
                UserDefaults.standard.set(true, forKey: "login")
                UserDefaults.standard.set(phone, forKey: "phone")
                UserDefaults.standard.synchronize()
                containerController.currentState = .bothCollapsed
                containerController.leftViewController?.view.removeFromSuperview()
                containerController.leftViewController = nil
                containerController.setupController()
                self.dismiss(animated: true, completion: nil)
            })
            
        }
    }
}
