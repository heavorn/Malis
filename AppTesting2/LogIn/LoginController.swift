//
//  LoginController.swift
//  AppTesting2
//
//  Created by Sovorn on 10/18/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainColor()
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
    
    let containerView2: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .clear
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.tintColor = .mainColor()
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(white: 1, alpha: 0.6)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
        
        return button
    }()
    
    let invalidLabel: UILabel = {
        let label = UILabel()
        label.text = "Please try again!"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.isHidden = true
        
        return label
    }()
    
    @objc func handleLogin(){
//        guard let credential = UserDefaults.standard.object(forKey: "credentialCode") else {return}
        guard let phoneNumber = phoneTextField.text, let password = passwordTextField.text else {return}
        
        
        Database.database().reference().child("users").child("+855\(phoneNumber)").observeSingleEvent(of: .value, with: { (snapshot) in
            print("child")
            if let dic = snapshot.value as? [String: Any]{
                if dic["password"] as? String == password{
                    guard let containerController = UIApplication.shared.keyWindow?.rootViewController as? ContainerViewController else {return}
                    UserDefaults.standard.set(true, forKey: "login")
                    UserDefaults.standard.set("+855\(phoneNumber)", forKey: "phone")
                    UserDefaults.standard.synchronize()
                    containerController.currentState = .bothCollapsed
                    containerController.leftViewController?.view.removeFromSuperview()
                    containerController.leftViewController = nil
                    containerController.setupController()
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.invalidLabel.isHidden = false
                    print("Failed to log in")
                    return
                }
            }
        }, withCancel: nil)
    }
    
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
    
    let sigupButton: UIButton = {
        let button = UIButton(type: .system)
        let attributeTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(white: 0, alpha: 0.5)])
        attributeTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributeTitle, for: .normal)
        button.addTarget(self, action: #selector(handleDontHaveAccount), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDontHaveAccount(){
        let signupController = SignUpController()
        navigationController?.pushViewController(signupController, animated: true)
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
        
        let stackView = UIStackView(arrangedSubviews: [containerView, containerView2, loginButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 8
        
        view.addSubview(stackView)
        view.addSubview(titleView)
        view.addSubview(sigupButton)
        view.addSubview(invalidLabel)
        containerView.addSubview(countryCode)
        containerView.addSubview(separateLine)
        containerView.addSubview(phoneTextField)
        containerView2.addSubview(passwordTextField)
        
        stackView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 120 + 16)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        invalidLabel.anchor(top: stackView.bottomAnchor, left: stackView.leftAnchor, bottom: nil, right: stackView.rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 15)
        
        titleView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        passwordTextField.anchor(top: containerView2.topAnchor, left: containerView2.leftAnchor, bottom: containerView2.bottomAnchor, right: containerView2.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        countryCode.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: separateLine.leftAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 55, height: 0)
        
        separateLine.anchor(top: containerView.topAnchor, left: countryCode.rightAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 1, height: 0)
        
        phoneTextField.anchor(top: containerView.topAnchor, left: countryCode.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        sigupButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func handleTextInputChange(){
        invalidLabel.isHidden = true
        let isFormValid = (phoneTextField.text?.count)! > 0 && (passwordTextField.text?.count)! > 0
        
        
        if isFormValid {
            loginButton.backgroundColor = .white
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = UIColor(white: 1, alpha: 0.6)
            loginButton.isEnabled = false
        }
    }
    
}
