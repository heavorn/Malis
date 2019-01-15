//
//  SignUpController.swift
//  AppTesting2
//
//  Created by Sovorn on 10/18/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainColor()
        navigationController?.navigationBar.isHidden = true
        self.hideKeyBoardWhenTappedAround()
        
        setupLogin()
        
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let containerView3: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let containerView1: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.tintColor = .mainColor()
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(white: 1, alpha: 0.6)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        
        return button
    }()
    
    let countryCode: UITextField = {
        let tf = UITextField()
        tf.text = "+855"
        tf.tintColor = UIColor(white: 0, alpha: 0.5)
        tf.isUserInteractionEnabled = false
        
        return tf
    }()
    
    let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Phone number"
        tf.keyboardType = UIKeyboardType.phonePad
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let userName: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter your name"
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .clear
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let invalidLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone number is already registered."
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.isHidden = true
        
        return label
    }()
    
    var verifyController = VerifyController()
    var verifyID: String?
    
    @objc func handleSignup(){
        guard let phone = self.phoneTextField.text, let name = self.userName.text, let password = self.passwordTextField.text else {return}
        print("+855\(phone)")
        
        Database.database().reference().child("users").child("+855\(phone)").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dic = snapshot.value as? [String: Any]{
                self.invalidLabel.isHidden = false
                print("Failed to sign up")
                return
            } else {
                PhoneAuthProvider.provider().verifyPhoneNumber("+855\(phone)", uiDelegate: nil) { (verificationID, error) in
                    if (error != nil) {
                        print("error: \(error!.localizedDescription)")
                        return
                    }
                    self.verifyID = verificationID
                    //            UserDefaults.standard.set(verificationID, forKey: "authVID")
                    //            UserDefaults.standard.synchronize()
                    //
                    //            self.performSegue(withIdentifier: "enterVerificationCode", sender: self)
                    self.verifyController.verifyID = self.verifyID
                    self.verifyController.name = name
                    self.verifyController.phone = "+855\(phone)"
                    self.verifyController.passWord = password
                    self.navigationController?.pushViewController(self.verifyController, animated: true)
                    
                }
            }
        }) { (_) in

        }
    }
    
    let signinButton: UIButton = {
        let button = UIButton(type: .system)
        let attributeTitle = NSMutableAttributedString(string: "Alreadt have an account? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(white: 0, alpha: 0.5)])
        attributeTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributeTitle, for: .normal)
        button.addTarget(self, action: #selector(handleAlreadyHaveAccount), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleAlreadyHaveAccount(){
        navigationController?.popViewController(animated: true)
    }
    
    private func setupLogin(){
        
        let separateLine = UIView()
        separateLine.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        let titleView: UILabel = {
            let tv = UILabel()
            tv.text = "Malis"
            tv.font = UIFont(name: "Noteworthy-Light", size: 64)
            tv.textColor = .white
            tv.textAlignment = .center
            
            return tv
        }()
        
        let stackView = UIStackView(arrangedSubviews: [containerView, containerView3, containerView1, signUpButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 6
        
        view.addSubview(stackView)
        view.addSubview(titleView)
        view.addSubview(signinButton)
        view.addSubview(invalidLabel)
        containerView.addSubview(userName)
        containerView1.addSubview(countryCode)
        containerView1.addSubview(separateLine)
        containerView1.addSubview(phoneTextField)
        containerView3.addSubview(passwordTextField)
        
        stackView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 184)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        invalidLabel.anchor(top: stackView.bottomAnchor, left: stackView.leftAnchor, bottom: nil, right: stackView.rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 15)
        
        titleView.anchor(top: nil, left: view.leftAnchor, bottom: containerView1.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 180, paddingRight: 0, width: 0, height: 0)
        
        passwordTextField.anchor(top: containerView3.topAnchor, left: containerView3.leftAnchor, bottom: containerView3.bottomAnchor, right: containerView3.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        userName.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        countryCode.anchor(top: containerView1.topAnchor, left: containerView1.leftAnchor, bottom: containerView1.bottomAnchor, right: separateLine.leftAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 55, height: 0)
        
        separateLine.anchor(top: containerView1.topAnchor, left: countryCode.rightAnchor, bottom: containerView1.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 1, height: 0)
        
        phoneTextField.anchor(top: containerView1.topAnchor, left: countryCode.rightAnchor, bottom: containerView1.bottomAnchor, right: containerView1.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        signinButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
    }
    
    @objc func handleTextInputChange(){
        let isFormValid = (userName.text?.count)! > 0 && (phoneTextField.text?.count)! > 0 && (passwordTextField.text?.count)! > 0
        invalidLabel.isHidden = true
        
        if isFormValid {
            signUpButton.backgroundColor = .white
            signUpButton.isEnabled = true
        } else {
            signUpButton.backgroundColor = UIColor(white: 1, alpha: 0.6)
            signUpButton.isEnabled = false
        }
    }
    
}

