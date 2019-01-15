//
//  ProfileController.swift
//  AppTesting2
//
//  Created by Sovorn on 10/13/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

private enum State {
    case closed
    case open
}

extension State {
    var opposite: State {
        switch self {
        case .open:
            return .closed
        default:
            return .open
        }
    }
}

class ProfileController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProfileCellDelegate {
    
    let cellId = "cellId"
    
    var imgArray: [UIImage]?
    var images: [String]?
    
    var salon: Salon? {
        didSet {
            images = [salon?.image1, salon?.image2, salon?.image3, salon?.image4, salon?.image5, salon?.image6, salon?.image7, salon?.image8, salon?.image9, salon?.image10] as? [String]
            for index in 0...9 {
                let imageView = CustomImageView()
                imageView.loadImage(urlString: images![index])
                imgArray?.append(imageView.image!)
            }
            
            navigationItem.title = salon?.name
            profileImageView.loadImage(urlString: (salon?.profileUrl)!)
            
            let atttributeText1 = NSMutableAttributedString(string: "Service", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            atttributeText1.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 8)]))
            atttributeText1.append(NSAttributedString(string: (salon?.service)!, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
            postsLabel.attributedText = atttributeText1
            
            let atttributeText2 = NSMutableAttributedString(string: "Discount", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            atttributeText2.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 5)]))
            atttributeText2.append(NSAttributedString(string: "\((salon?.discount)!)%", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
            followingLabel.attributedText = atttributeText2
            
            let atttributeText3 = NSMutableAttributedString(string: "Price", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            atttributeText3.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 5)]))
            atttributeText3.append(NSAttributedString(string: "$\((salon?.price)!)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
            followersLabel.attributedText = atttributeText3
        }
    }
    
    private var bottomConstraint = NSLayoutConstraint()
    private var closedConstraint = NSLayoutConstraint()
    private var stackTopConstraint = NSLayoutConstraint()
    private let popupOffset: CGFloat = 210
    
    private lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.addGestureRecognizer(panRecognizerII)
        
        return view
    }()
    
    let containerView = UIView()
    lazy var popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var closedTitleLabel: UIButton = {
        let label = UIButton(type: .system)
        label.setTitle("BOOK", for: .normal)
        label.backgroundColor = .mainColor()
        label.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.heavy)
        label.setTitleColor(.white, for: .normal)
        label.addGestureRecognizer(panRecognizer)
        
        return label
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
        self.view.endEditing(true)
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
                    UIView.animate(withDuration: 0.4, delay: 0.4, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: .curveEaseOut, animations: {
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
    
    let collectionViewController = UICollectionView(frame: CGRect(x: 0, y: 88 + 130, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 130 - 88), collectionViewLayout: UICollectionViewFlowLayout())
    
    
    var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space = (self.navigationController?.navigationBar.frame.maxY)!
        
        collectionViewController.delegate = self
        collectionViewController.dataSource = self
        collectionViewController.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        collectionViewController.register(ProfileCell.self, forCellWithReuseIdentifier: cellId)
        collectionViewController.backgroundColor  = .white
        collectionViewController.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor.rgb(red: 234, green: 137, blue: 129)
        let textAttribute = [NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 234, green: 137, blue: 129)]
        navigationController?.navigationBar.titleTextAttributes = textAttribute
        containerView.frame = CGRect(x: 0, y: space, width: UIScreen.main.bounds.size.width, height: 130)
        view.addSubview(containerView)
        view.addSubview(collectionViewController)
        setupHeader()
        setupButton()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionViewController.contentOffset.y < 0 {
            collectionViewController.contentOffset.y = 0
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            UIView.animate(withDuration: 0.15) {
                self.bottomConstraint.isActive = false
                self.bottomConstraint.constant = -(keyboardHeight) + 50
                self.bottomConstraint.isActive = true
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        UIView.animate(withDuration: 0.15) {
            self.bottomConstraint.isActive = false
            self.bottomConstraint.constant = 0
            self.bottomConstraint.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    let profileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        
        return imageView
    }()
    
    let postsLabel: UILabel = {
        let label = UILabel()
        let atttributeText = NSMutableAttributedString(string: "Service", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        atttributeText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 8)]))
        atttributeText.append(NSAttributedString(string: "ផាត់មុខតាមផ្ទះ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        label.attributedText = atttributeText
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        let atttributeText = NSMutableAttributedString(string: "Price", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        atttributeText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 5)]))
        atttributeText.append(NSAttributedString(string: "$15-$25", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        label.attributedText = atttributeText
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        let atttributeText = NSMutableAttributedString(string: "Discount", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        atttributeText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 5)]))
        atttributeText.append(NSAttributedString(string: "5%", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        label.attributedText = atttributeText
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    private func setupHeader(){
        
        containerView.addSubview(profileImageView)
        profileImageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 110, height: 110)
        
        setupUserStatsView()
    }
    
    private func setupUserStatsView(){
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        stackView.distribution = .fillEqually
        containerView.addSubview(stackView)
        
        stackView.anchor(top: containerView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 30, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileCell
        cell.delegate = self
        cell.photo.loadImage(urlString: images![indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 1) / 2, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! ProfileHeader
        header.des = salon?.description
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 130)
    }
    
    var startingFrame: CGRect?
    var blackBackground: UIView?
    var startingImage: UIImageView?
    
    
    func performZoomForImageView(imageView: UIImageView){
        self.startingImage = imageView
        self.startingImage?.isHidden = true
        startingFrame = imageView.superview?.convert(imageView.frame, to: nil)
        let zoomImageView = UIImageView(frame: startingFrame!)
        zoomImageView.image = imageView.image
        zoomImageView.contentMode = .scaleAspectFill
        zoomImageView.clipsToBounds = true
        zoomImageView.isUserInteractionEnabled = true
        zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
        if let keyWindow = UIApplication.shared.keyWindow {
            self.blackBackground = UIView(frame: keyWindow.frame)
            self.blackBackground?.backgroundColor = .black
            self.blackBackground?.alpha = 0
            
            keyWindow.addSubview(self.blackBackground!)
            keyWindow.addSubview(zoomImageView)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackBackground?.alpha = 1
                self.containerView.alpha = 0
                
                //h2 / w2 = h1 / w1 so h2 = h1 / w1 * w2
                
                let height = self.startingFrame!.height / self.startingFrame!.width * keyWindow.frame.width
                
                zoomImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                zoomImageView.center = keyWindow.center
            }, completion: nil)
        }
    }
    
    @objc func handleZoomOut(tapGesture: UITapGestureRecognizer){
        if let zoomImage = tapGesture.view {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                zoomImage.frame = self.startingFrame!
                self.blackBackground?.alpha = 0
                self.containerView.alpha = 1
            }) { (completed: Bool) in
                zoomImage.removeFromSuperview()
                self.startingImage?.isHidden = false
            }
            
        }
    }
    
    
    /// The current state of the animation. This variable is changed only when an animation completes.
    private var currentState: State = .closed
    
    private func setupButton(){
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)
        overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        overlayView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(popupView)
        popupView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 260)
        bottomConstraint = popupView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: popupOffset)
        bottomConstraint.isActive = true
        
        popupView.addSubview(closedTitleLabel)
        closedTitleLabel.anchor(top: popupView.topAnchor, left: popupView.leftAnchor, bottom: nil, right: popupView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        closedConstraint = closedTitleLabel.heightAnchor.constraint(equalToConstant: 50)
        closedConstraint.isActive = true

        stackView = UIStackView(arrangedSubviews: [containerView3, containerView4])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 8
        popupView.addSubview(stackView)
        popupView.addSubview(bookButton)
        stackView.anchor(top: nil, left: popupView.leftAnchor, bottom: nil, right: popupView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 80 + 16)
        stackTopConstraint = stackView.topAnchor.constraint(equalTo: closedTitleLabel.bottomAnchor, constant: 35)
        stackTopConstraint.isActive = true
        bookButton.anchor(top: stackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 40)
        
        containerView3.addSubview(locationImageView)
        containerView3.addSubview(pickLocation)
        
        locationImageView.anchor(top: containerView3.topAnchor, left: containerView3.leftAnchor, bottom: containerView3.bottomAnchor, right: pickLocation.leftAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 25, height: 25)
        pickLocation.anchor(top: containerView3.topAnchor, left: locationImageView.rightAnchor, bottom: containerView3.bottomAnchor, right: containerView3.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        containerView4.addSubview(timeTextContainer)
        containerView4.addSubview(dateTextContainer)
        timeTextContainer.addSubview(timeImageView)
        timeTextContainer.addSubview(timeTextField)
        dateTextContainer.addSubview(dateImageView)
        dateTextContainer.addSubview(dateTextField)
        
        timeTextContainer.anchor(top: containerView4.topAnchor, left: containerView4.leftAnchor, bottom: containerView4.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 0)
        dateTextContainer.anchor(top: containerView4.topAnchor, left: timeTextContainer.rightAnchor, bottom: containerView4.bottomAnchor, right: containerView4.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        timeImageView.anchor(top: timeTextContainer.topAnchor, left: timeTextContainer.leftAnchor, bottom: timeTextContainer.bottomAnchor, right: timeTextField.leftAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 25, height: 25)
        timeTextField.anchor(top: timeTextContainer.topAnchor, left: timeImageView.rightAnchor, bottom: timeTextContainer.bottomAnchor, right: timeTextContainer.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        dateImageView.anchor(top: dateTextContainer.topAnchor, left: dateTextContainer.leftAnchor, bottom: dateTextContainer.bottomAnchor, right: dateTextField.leftAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 20, height: 20)
        dateTextField.anchor(top: dateTextContainer.topAnchor, left: dateImageView.rightAnchor, bottom: dateTextContainer.bottomAnchor, right: dateTextContainer.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    lazy var panRecognizerII: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(handleTapLayerView(recognizer:)))
        recognizer.cancelsTouchesInView = false
        
        return recognizer
    }()
    
    lazy var panRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(popupViewTapped(recognizer:)))
        recognizer.cancelsTouchesInView = false
        
        return recognizer
    }()
    
    @objc func handleTapLayerView(recognizer: UITapGestureRecognizer){
        view.endEditing(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        let transitionAnimator = UIViewPropertyAnimator(duration: 0.55, dampingRatio: 0.9) {
            self.bottomConstraint.constant = self.popupOffset
            self.popupView.layer.cornerRadius = 0
            self.overlayView.alpha = 0
            self.closedTitleLabel.backgroundColor = .mainColor()
            self.closedTitleLabel.setTitle("BOOK", for: .normal)
            self.closedTitleLabel.setTitleColor(.white, for: .normal)
            self.closedConstraint.isActive = false
            self.closedConstraint = self.closedTitleLabel.heightAnchor.constraint(equalToConstant: 50)
            self.closedConstraint.isActive = true
            self.stackTopConstraint.isActive = false
            self.stackTopConstraint.constant = 35
            self.stackTopConstraint.isActive = true
            self.view.layoutIfNeeded()
            self.currentState = self.currentState.opposite
        }
        transitionAnimator.startAnimation()
    }
    
    @objc func popupViewTapped(recognizer: UITapGestureRecognizer){
        view.endEditing(true)
        let state = currentState.opposite
        let transitionAnimator = UIViewPropertyAnimator(duration: 0.55, dampingRatio: 0.9, animations: {
            switch state {
            case .open:
                NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
                self.bottomConstraint.constant = 0
                self.popupView.layer.cornerRadius = 20
                self.overlayView.alpha = 0.5
                self.closedTitleLabel.backgroundColor = .clear
                self.closedTitleLabel.setTitle("Booking Request", for: .normal)
                self.closedTitleLabel.setTitleColor(.mainColor(), for: .normal)
                self.closedConstraint.isActive = false
                self.closedConstraint = self.closedTitleLabel.heightAnchor.constraint(equalToConstant: 60)
                self.stackTopConstraint.isActive = false
                self.stackTopConstraint.constant = 0
                self.stackTopConstraint.isActive = true
                self.closedConstraint.isActive = true
                
            case .closed:
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
                self.bottomConstraint.constant = self.popupOffset
                self.popupView.layer.cornerRadius = 0
                self.overlayView.alpha = 0
                self.closedTitleLabel.backgroundColor = .mainColor()
                self.closedTitleLabel.setTitle("BOOK", for: .normal)
                self.closedTitleLabel.setTitleColor(.white, for: .normal)
                self.closedConstraint.isActive = false
                self.closedConstraint = self.closedTitleLabel.heightAnchor.constraint(equalToConstant: 50)
                self.closedConstraint.isActive = true
                self.stackTopConstraint.isActive = false
                self.stackTopConstraint.constant = 35
                self.stackTopConstraint.isActive = true
            }
            self.view.layoutIfNeeded()
        })
        transitionAnimator.addCompletion { position in
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            }
            switch self.currentState {
            case .open:
                self.bottomConstraint.constant = 0
            case .closed:
                self.bottomConstraint.constant = self.popupOffset
            }
        }
        transitionAnimator.startAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
    }
}

