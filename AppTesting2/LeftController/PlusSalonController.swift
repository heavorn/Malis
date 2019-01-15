//
//  PlusSalonController.swift
//  AppTesting2
//
//  Created by Sovorn on 10/25/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

class PlusSalonController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let containerView = UIView()
    
    let group = DispatchGroup()
    
    var salon: Salon? {
        didSet {
            
            assignImage()
            
            profile.layer.cornerRadius = 20
            profile.clipsToBounds = true
            profile.contentMode = .scaleAspectFill
            
            photo1.layer.cornerRadius = 8
            photo1.clipsToBounds = true
            photo1.contentMode = .scaleAspectFill
            
            photo2.layer.cornerRadius = 8
            photo2.clipsToBounds = true
            photo2.contentMode = .scaleAspectFill
            
            photo3.layer.cornerRadius = 8
            photo3.clipsToBounds = true
            photo3.contentMode = .scaleAspectFill
            
            photo4.layer.cornerRadius = 8
            photo4.clipsToBounds = true
            photo4.contentMode = .scaleAspectFill
            
            photo5.layer.cornerRadius = 8
            photo5.clipsToBounds = true
            photo5.contentMode = .scaleAspectFill
            
            photo6.layer.cornerRadius = 8
            photo6.clipsToBounds = true
            photo6.contentMode = .scaleAspectFill
            
            photo7.layer.cornerRadius = 8
            photo7.clipsToBounds = true
            photo7.contentMode = .scaleAspectFill
            
            photo8.layer.cornerRadius = 8
            photo8.clipsToBounds = true
            photo8.contentMode = .scaleAspectFill
            
            photo9.layer.cornerRadius = 8
            photo9.clipsToBounds = true
            photo9.contentMode = .scaleAspectFill
            
            photo10.layer.cornerRadius = 8
            photo10.clipsToBounds = true
            photo10.contentMode = .scaleAspectFill
            
            nameTextField.text = salon?.name
            serviceTextField.text = salon?.service
            priceTextField.text = salon?.price
            discountTextField.text = salon?.discount
            phoneTextField.text = salon?.phone
            descriptionTextField.text = salon?.description
            
        }
    }
    
    var images = [UIImage]()
    var preImages = [UIImage]()
    
    func assignImage(){
        
        profile.loadImage(urlString: (salon?.profileUrl)!)
        photo1.loadImage(urlString: (salon?.image1)!)
        photo2.loadImage(urlString: (salon?.image2)!)
        photo3.loadImage(urlString: (salon?.image3)!)
        photo4.loadImage(urlString: (salon?.image4)!)
        photo5.loadImage(urlString: (salon?.image5)!)
        photo6.loadImage(urlString: (salon?.image6)!)
        photo7.loadImage(urlString: (salon?.image7)!)
        photo8.loadImage(urlString: (salon?.image8)!)
        photo9.loadImage(urlString: (salon?.image9)!)
        photo10.loadImage(urlString: (salon?.image10)!)
        
        preImages.append(profile.image!)
        preImages.append(photo1.image!)
        preImages.append(photo2.image!)
        preImages.append(photo3.image!)
        preImages.append(photo4.image!)
        preImages.append(photo5.image!)
        preImages.append(photo6.image!)
        preImages.append(photo7.image!)
        preImages.append(photo8.image!)
        preImages.append(photo9.image!)
        preImages.append(photo10.image!)
    }
    
    var i = 0
    
    lazy var profile: CustomImageView = {
        let button = CustomImageView()
        button.image = UIImage(named: "plus_photo")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .mainColor()
        button.isUserInteractionEnabled = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfile)))
        
        return button
    }()
    
    @objc func handleProfile(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        i = 0
        
        present(picker, animated: true)
    }
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Salon's name"
        tf.layer.borderColor = UIColor.mainColor().cgColor
        tf.layer.borderWidth = 1
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 6
        tf.isEnabled = false
        
        return tf
    }()
    
    let serviceTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Service"
        tf.layer.borderColor = UIColor.mainColor().cgColor
        tf.layer.borderWidth = 1
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 6
        tf.isEnabled = false
        
        return tf
    }()
    
    let priceTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Price"
        tf.layer.borderColor = UIColor.mainColor().cgColor
        tf.layer.borderWidth = 1
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 6
        tf.isEnabled = false
        
        return tf
    }()
    
    let discountTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Discount"
        tf.layer.borderColor = UIColor.mainColor().cgColor
        tf.layer.borderWidth = 1
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 6
        tf.isEnabled = false
        
        return tf
    }()
    
    let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Phone number"
        tf.layer.borderColor = UIColor.mainColor().cgColor
        tf.layer.borderWidth = 1
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 6
        tf.isEnabled = false
        
        return tf
    }()
    
    
    let descriptionTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "description"
        tf.layer.borderColor = UIColor.mainColor().cgColor
        tf.layer.borderWidth = 1
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 10
        tf.isEnabled = false
        
        return tf
    }()
    
    let backImage: UIImage = {
        var image = UIImage(named: "icon_back")
        image = image?.imageWithColor(color1: .mainColor())
        
        return image!
    }()
    
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mainColor()
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.isHidden = true
        button.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleEdit(){
        editButton.isHidden = true
        uploadButton.isHidden = false
        profile.isUserInteractionEnabled = true
        photo1.isUserInteractionEnabled = true
        photo2.isUserInteractionEnabled = true
        photo3.isUserInteractionEnabled = true
        photo4.isUserInteractionEnabled = true
        photo5.isUserInteractionEnabled = true
        photo6.isUserInteractionEnabled = true
        photo7.isUserInteractionEnabled = true
        photo8.isUserInteractionEnabled = true
        photo9.isUserInteractionEnabled = true
        photo10.isUserInteractionEnabled = true
        
        nameTextField.isEnabled = true
        serviceTextField.isEnabled = true
        priceTextField.isEnabled = true
        discountTextField.isEnabled = true
        descriptionTextField.isEnabled = true
    }
    
    let uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("UPLOAD", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mainColor()
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleUpload), for: .touchUpInside)
        
        return button
    }()
    
    var isEdit: Bool = false
    var editArray = [Int]()
    
    @objc func handleUpload(){
        
        editButton.isHidden = false
        uploadButton.isHidden = true
        
        profile.isUserInteractionEnabled = false
        photo1.isUserInteractionEnabled = false
        photo2.isUserInteractionEnabled = false
        photo3.isUserInteractionEnabled = false
        photo4.isUserInteractionEnabled = false
        photo5.isUserInteractionEnabled = false
        photo6.isUserInteractionEnabled = false
        photo7.isUserInteractionEnabled = false
        photo8.isUserInteractionEnabled = false
        photo9.isUserInteractionEnabled = false
        photo10.isUserInteractionEnabled = false
        
        nameTextField.isEnabled = false
        serviceTextField.isEnabled = false
        priceTextField.isEnabled = false
        discountTextField.isEnabled = false
        descriptionTextField.isEnabled = false
        
        guard let phone = phoneTextField.text, let name = nameTextField.text, let service = serviceTextField.text, let price = priceTextField.text, let discount = discountTextField.text, let description = descriptionTextField.text else {return}
        guard let image0 = profile.image, let image1 = photo1.image, let image2 = photo2.image, let image3 = photo3.image, let image4 = photo4.image, let image5 = photo5.image, let image6 = photo6.image, let image7 = photo7.image, let image8 = photo8.image, let image9 = photo9.image, let image10 = photo10.image else {return}
        let images = [image0, image1, image2, image3, image4, image5, image6, image7, image8, image9, image10]
        
        if isEdit {
            var values: [String: String] = ["phone": phone, "name": name, "service": service, "price": price, "discount": discount, "description": description, "profileUrl": (salon?.profileUrl)!, "image1": (salon?.image1)!, "image2": (salon?.image2)!, "image3": (salon?.image3)!, "image4": (salon?.image4)!, "image5": (salon?.image5)!, "image6": (salon?.image6)!, "image7": (salon?.image7)!, "image8": (salon?.image8)!, "image9": (salon?.image9)!, "image10": (salon?.image10)!]
            for index in 0...10 {
                print("HAHA")
                if images[index] != preImages[index] {
                    group.enter()
                    Storage.storage().reference().child("salonPhoto").child(phone).child("\(index).jpg").delete { (error) in
                        if (error != nil){
                            print("Failed ot delete photo", error!)
                        }
                        print("Append")
                        self.editArray.append(index)
                        self.group.leave()
                    }
                }
            }
            
            group.notify(queue: .main) {
                for index in 0..<self.editArray.count {
                    self.group.enter()
                    let storage = Storage.storage().reference().child("salonPhoto").child(phone)
                    if self.editArray[index] == 0 {
                        //                    guard let profileData = image0.jpegData(compressionQuality: 0.2) else {return}
                        guard let profileData = image0.jpegData(compressionQuality: 0) else {return}
                        storage.child("0.jpg").putData(profileData, metadata: nil) { (metadata, error) in
                            if (error != nil){
                                print(error!)
                                return
                            }
                            storage.child("0.jpg").downloadURL(completion: { (url, error) in
                                if (error != nil){
                                    print(error!)
                                    return
                                }
                                if let imageUrl = url?.absoluteString {
                                    values["profileUrl"] = imageUrl
                                }
                            })
                        }
                        
                    } else {
                        //                    guard let uploadData = images[editArray[index]].jpegData(compressionQuality: 0.3) else {return}
                        guard let uploadData = images[self.editArray[index]].jpegData(compressionQuality: 0) else {return}
                        let storage = Storage.storage().reference().child("salonPhoto").child(phone).child("\(self.editArray[index]).jpg")
                        storage.putData(uploadData, metadata: nil) { (metadata, error) in
                            if (error != nil){
                                print("Failed to upload to storage", error!)
                                return
                            }
                            print("Store")
                            storage.downloadURL(completion: { (url, error) in
                                if (error != nil){
                                    print("Failed to downloadURL", error!)
                                    return
                                }
                                if let imageUrl = url?.absoluteString {
                                    values["image\(self.editArray[index])"] = imageUrl
                                    self.group.leave()
                                }
                            })
                        }
                    }
                }
                self.group.notify(queue: .main) {
                    Database.database().reference().child("salon").child(phone).updateChildValues(values) { (error, ref) in
                        if (error != nil){
                            print("Failed to upload to database", error!)
                            return
                        }
                        print("Upload Successfully")
                    }
                }
            }
        } else {
            var imageURLs = [String]()
            var profileUrlString: String?
//            guard let profileData = image0.jpegData(compressionQuality: 0.2) else {return}
            guard let profileData = image0.jpegData(compressionQuality: 0) else {return}
            let profileStorage = Storage.storage().reference().child("salonPhoto").child(phone).child("0.jpg")
            profileStorage.putData(profileData, metadata: nil) { (metadata, error) in
                if (error != nil){
                    print(error!)
                    return
                }
                profileStorage.downloadURL(completion: { (url, error) in
                    if (error != nil){
                        print(error!)
                        return
                    }
                    if let imageUrl = url?.absoluteString {
                        profileUrlString = imageUrl
                    }
                })
            }
            
            var i = 1
            while i <= 10 {
                group.enter()
//                guard let uploadData = images[i].jpegData(compressionQuality: 0.3) else {return}
                guard let uploadData = images[i].jpegData(compressionQuality: 0) else {return}
                let storage = Storage.storage().reference().child("salonPhoto").child(phone).child("\(i).jpg")
                storage.putData(uploadData, metadata: nil) { (metadata, error) in
                    if (error != nil){
                        print("Failed to upload to storage", error!)
                        return
                    }
                    print("Store")
                    storage.downloadURL(completion: { (url, error) in
                        if (error != nil){
                            print("Failed to downloadURL", error!)
                            return
                        }
                        if let imageUrl = url?.absoluteString {
                            imageURLs.append(imageUrl)
                            self.group.leave()
                        }
                    })
                }
                i = i + 1
            }
            
            group.notify(queue: .main) {
                let values: [String: String] = ["phone": phone, "name": name, "service": service, "price": price, "discount": discount, "description": description, "profileUrl": profileUrlString!, "image1": imageURLs[0], "image2": imageURLs[1], "image3": imageURLs[2], "image4": imageURLs[3], "image5": imageURLs[4], "image6": imageURLs[5], "image7": imageURLs[6], "image8": imageURLs[7], "image9": imageURLs[8], "image10": imageURLs[9]]
                Database.database().reference().child("salon").child(phone).updateChildValues(values) { (error, ref) in
                    if (error != nil){
                        print("Failed to upload to database", error!)
                        return
                    }
                    print("Upload Successfully")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyBoardWhenTappedAround()
        let space = (self.navigationController?.navigationBar.frame.maxY)!
        
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .mainColor()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(handleBack))
        containerView.frame = CGRect(x: 0, y: space, width: UIScreen.main.bounds.size.width, height: 400)
        view.addSubview(containerView)
        setupLayout()
        setupPhotoUpload()
    }
    
    private func setupLayout(){
        let stackView = UIStackView(arrangedSubviews: [nameTextField, serviceTextField, priceTextField, discountTextField])
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        stackView.axis = .vertical
        
        containerView.addSubview(profile)
        containerView.addSubview(stackView)
        containerView.addSubview(descriptionTextField)
        containerView.addSubview(phoneTextField)
        
        profile.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: stackView.leftAnchor, paddingTop: 50, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 150, height: 150)
        stackView.anchor(top: profile.topAnchor, left: profile.rightAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 0, height: 120 + 18)
        
        phoneTextField.anchor(top: stackView.bottomAnchor, left: containerView.leftAnchor, bottom: descriptionTextField.topAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 20, width: 0, height: 30)
        
        descriptionTextField.anchor(top: phoneTextField.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 20, width: 0, height: 0)
        
    }
    
    private func setupPhotoUpload(){
        let stackView1 = UIStackView(arrangedSubviews: [photo1, photo2, photo3, photo4, photo5])
        stackView1.distribution = .fillEqually
        stackView1.axis = .horizontal
        stackView1.spacing = 8
        
        let stackView2 = UIStackView(arrangedSubviews: [photo6, photo7, photo8, photo9, photo10])
        stackView2.distribution = .fillEqually
        stackView2.axis = .horizontal
        stackView2.spacing = 8
        
        view.addSubview(stackView1)
        view.addSubview(stackView2)
        view.addSubview(uploadButton)
        view.addSubview(editButton)
        stackView1.anchor(top: containerView.bottomAnchor, left: view.leftAnchor, bottom: stackView2.topAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 60)
        stackView2.anchor(top: stackView1.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 60)
        uploadButton.anchor(top: stackView2.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 50)
        editButton.anchor(top: stackView2.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 50)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image = UIImage()
        
        if let editImage = info[.editedImage] as? UIImage {
            image = editImage
        } else if let origialImage = info[.originalImage] as? UIImage{
            image = origialImage
        }
        
        switch self.i {
        case 0:
            profile.image = image.withRenderingMode(.alwaysOriginal)
            profile.layer.cornerRadius = 20
            profile.layer.masksToBounds = true
        case 1:
            photo1.image = image.withRenderingMode(.alwaysOriginal)
            photo1.layer.cornerRadius = 8
            photo1.layer.masksToBounds = true
        case 2:
            photo2.image = image.withRenderingMode(.alwaysOriginal)
            photo2.layer.cornerRadius = 8
            photo2.layer.masksToBounds = true
        case 3:
            photo3.image = image.withRenderingMode(.alwaysOriginal)
            photo3.layer.cornerRadius = 8
            photo3.layer.masksToBounds = true
        case 4:
            photo4.image = image.withRenderingMode(.alwaysOriginal)
            photo4.layer.cornerRadius = 8
            photo4.layer.masksToBounds = true
        case 5:
            photo5.image = image.withRenderingMode(.alwaysOriginal)
            photo5.layer.cornerRadius = 8
            photo5.layer.masksToBounds = true
        case 6:
            photo6.image = image.withRenderingMode(.alwaysOriginal)
            photo6.layer.cornerRadius = 8
            photo6.layer.masksToBounds = true
        case 7:
            photo7.image = image.withRenderingMode(.alwaysOriginal)
            photo7.layer.cornerRadius = 8
            photo7.layer.masksToBounds = true
        case 8:
            photo8.image = image.withRenderingMode(.alwaysOriginal)
            photo8.layer.cornerRadius = 8
            photo8.layer.masksToBounds = true
        case 9:
            photo9.image = image.withRenderingMode(.alwaysOriginal)
            photo9.layer.cornerRadius = 8
            photo9.layer.masksToBounds = true
        case 10:
            photo10.image = image.withRenderingMode(.alwaysOriginal)
            photo10.layer.cornerRadius = 8
            photo10.layer.masksToBounds = true
        default:
            break
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleBack(){
//        guard let containerController = UIApplication.shared.keyWindow?.rootViewController as? ContainerViewController else {return}
//        containerController.currentState = .bothCollapsed
//        containerController.leftViewController?.view.removeFromSuperview()
//        containerController.leftViewController = nil
//        containerController.setupController()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
    }
    
    lazy var photo1: CustomImageView = {
        let button = CustomImageView()
        button.image = UIImage(named: "plus_photo")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .mainColor()
        button.isUserInteractionEnabled = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhoto1)))
        
        return button
    }()
    
    @objc func handlePhoto1(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        i = 1
        
        present(picker, animated: true)
    }
    
    lazy var photo2: CustomImageView = {
        let button = CustomImageView()
        button.image = UIImage(named: "plus_photo")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .mainColor()
        button.isUserInteractionEnabled = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhoto2)))
        
        return button
    }()
    
    @objc func handlePhoto2(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        i = 2
        
        present(picker, animated: true)
    }
    
    lazy var photo3: CustomImageView = {
        let button = CustomImageView()
        button.image = UIImage(named: "plus_photo")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .mainColor()
        button.isUserInteractionEnabled = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhoto3)))
        
        return button
    }()
    
    @objc func handlePhoto3(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        i = 3
        
        present(picker, animated: true)
    }
    
    lazy var photo4: CustomImageView = {
        let button = CustomImageView()
        button.image = UIImage(named: "plus_photo")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .mainColor()
        button.isUserInteractionEnabled = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhoto4)))
        
        return button
    }()
    
    @objc func handlePhoto4(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        i = 4
        
        present(picker, animated: true)
    }
    
    lazy var photo5: CustomImageView = {
        let button = CustomImageView()
        button.image = UIImage(named: "plus_photo")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .mainColor()
        button.isUserInteractionEnabled = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhoto5)))
        
        return button
    }()
    
    @objc func handlePhoto5(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        i = 5
        
        present(picker, animated: true)
    }
    
    lazy var photo6: CustomImageView = {
        let button = CustomImageView()
        button.image = UIImage(named: "plus_photo")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .mainColor()
        button.isUserInteractionEnabled = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhoto6)))
        
        return button
    }()
    
    @objc func handlePhoto6(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        i = 6
        
        present(picker, animated: true)
    }
    
    lazy var photo7: CustomImageView = {
        let button = CustomImageView()
        button.image = UIImage(named: "plus_photo")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .mainColor()
        button.isUserInteractionEnabled = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhoto7)))
        
        return button
    }()
    
    @objc func handlePhoto7(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        i = 7
        
        present(picker, animated: true)
    }
    
    lazy var photo8: CustomImageView = {
        let button = CustomImageView()
        button.image = UIImage(named: "plus_photo")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .mainColor()
        button.isUserInteractionEnabled = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhoto8)))
        
        return button
    }()
    
    @objc func handlePhoto8(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        i = 8
        
        present(picker, animated: true)
    }
    
    lazy var photo9: CustomImageView = {
        let button = CustomImageView()
        button.image = UIImage(named: "plus_photo")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .mainColor()
        button.isUserInteractionEnabled = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhoto9)))
        
        return button
    }()
    
    @objc func handlePhoto9(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        i = 9
        
        present(picker, animated: true)
    }
    
    lazy var photo10: CustomImageView = {
        let button = CustomImageView()
        button.image = UIImage(named: "plus_photo")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .mainColor()
        button.isUserInteractionEnabled = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhoto10)))
        
        return button
    }()
    
    @objc func handlePhoto10(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        i = 10
        
        present(picker, animated: true)
    }
    
}
