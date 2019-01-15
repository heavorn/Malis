//
//  ViewController.swift
//  AppTesting2
//
//  Created by Sovorn on 10/13/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

let statusBarSize = UIApplication.shared.statusBarFrame.size
let statusBarHeight = Swift.min(statusBarSize.width, statusBarSize.height)

protocol ViewControllerDelegate {
    func toggleLeftPanel()
    func collapseSidePanels()
    func tapLayerView()
//    func panLayerView(_ recognizer: UIPanGestureRecognizer)
}

class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomeCellDelegate {
    
    func handleBookButton(for cell: HomeCell) {
        guard let indexPath = collectionViewController.indexPath(for: cell) else {return}
        let salon = salons[indexPath.item]
        let profileController = ProfileController()
        profileController.salon = salon
        navigationController?.pushViewController(profileController, animated: true)
    }
    
    
    var delegate: ViewControllerDelegate?
    
    let cellId = "cellId"
    
    var collectionViewController: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 260 + statusBarHeight, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 260 - statusBarHeight), collectionViewLayout: UICollectionViewFlowLayout())
    let containerView = UIView()
    
    lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapLayer)))
//        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanLayer(_:))))
        
        return view
    }()
    
//    @objc func handlePanLayer(_ recognizer: UIPanGestureRecognizer){
//        delegate?.panLayerView(recognizer)
//    }
//    
    @objc func handleTapLayer(){
        delegate?.tapLayerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSalon()
        self.hideKeyBoardWhenTappedAround()
        self.collectionViewController.delegate = self
        self.collectionViewController.dataSource = self
        self.collectionViewController.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        self.collectionViewController.backgroundColor  = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        containerView.backgroundColor = UIColor.rgb(red: 234, green: 137, blue: 129)
        containerView.frame = CGRect(x: 0, y: statusBarHeight, width: UIScreen.main.bounds.size.width, height: 260)
        setupHeader()
        view.addSubview(containerView)
        view.addSubview(collectionViewController)
        view.addSubview(overlayView)
        overlayView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    private func fetchSalon(){
        let ref = Database.database().reference().child("salon")
        ref.observe(.childAdded, with: { (snapshot) in
            ref.child(snapshot.key).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dic = snapshot.value as? [String: String] {
                    let salon = Salon(dic: dic)
                    self.salons.append(salon)
                }
                print("LOL")
                self.filterSalons = self.salons
                self.collectionViewController.reloadData()
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.delegate = self
        sb.placeholder = "Search for makeup artist, hair..."
        sb.backgroundColor = .clear
        
        return sb
    }()
    
    
    var salons = [Salon]()
    var filterSalons = [Salon]()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filterSalons = salons
        } else {
            filterSalons = self.salons.filter({ (salon) -> Bool in
                return (salon.name.lowercased().contains(searchText.lowercased()))
            })
        }
        self.collectionViewController.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profileController = ProfileController()
        profileController.salon = self.filterSalons[indexPath.item]
        navigationController?.pushViewController(profileController, animated: true)
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resultLabel.text = "RESULT FOUND (\(self.filterSalons.count))"
        return self.filterSalons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        cell.delagate = self
        cell.salon = self.filterSalons[indexPath.item]
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    lazy var leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "list"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleLeftButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleLeftButton(){
        delegate?.toggleLeftPanel()
    }
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.rgb(red: 234, green: 137, blue: 129)
        label.textAlignment = .center
        
        return label
    }()
    
    private func setupHeader(){
        let titleView: UILabel = {
            let tv = UILabel()
            tv.text = "Malis"
            tv.font = UIFont(name: "Noteworthy-Light", size: 32)
            tv.textColor = .white
            tv.textAlignment = .center
            
            return tv
        }()
        
        let bottomView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            
            return view
        }()
        
        //StackView
        
        let allButton: UIButton = {
            let button = UIButton(type: .system)
            button.tintColor = .white
            button.setTitle("All", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.backgroundColor = UIColor.rgb(red: 234, green: 137, blue: 129)
            button.layer.cornerRadius = 15
            button.layer.masksToBounds = true
            
            return button
        }()
        
        let popularButton: UIButton = {
            let button = UIButton(type: .system)
            button.tintColor = UIColor(white: 0, alpha: 0.8)
            button.setTitle("Popular", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.backgroundColor = UIColor(white: 0, alpha: 0.2)
            button.layer.cornerRadius = 15
            button.layer.masksToBounds = true
            
            return button
        }()
        
        let makeupButton: UIButton = {
            let button = UIButton(type: .system)
            button.tintColor = UIColor(white: 0, alpha: 0.8)
            button.setTitle("Makeup", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.backgroundColor = UIColor(white: 0, alpha: 0.2)
            button.layer.cornerRadius = 15
            button.layer.masksToBounds = true
            
            return button
        }()
        
        let haircutButton: UIButton = {
            let button = UIButton(type: .system)
            button.tintColor = UIColor(white: 0, alpha: 0.8)
            button.setTitle("Haircut", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.backgroundColor = UIColor(white: 0, alpha: 0.2)
            button.layer.cornerRadius = 15
            button.layer.masksToBounds = true
            
            return button
        }()
        
        self.containerView.addSubview(titleView)
        self.containerView.addSubview(searchBar)
        self.containerView.addSubview(self.leftButton)
        searchBar.removeBackground()
        self.containerView.addSubview(bottomView)
        bottomView.addSubview(resultLabel)
        
        titleView.anchor(top: self.containerView.topAnchor, left: self.containerView.leftAnchor, bottom: nil, right: self.containerView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        self.leftButton.anchor(top: titleView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
        searchBar.anchor(top: nil, left: self.containerView.leftAnchor, bottom: bottomView.topAnchor, right: self.containerView.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 4, paddingRight: 12, width: 0, height: 0)
        titleView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
        bottomView.anchor(top: nil, left: self.containerView.leftAnchor, bottom: self.containerView.bottomAnchor, right: self.containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 86)
        resultLabel.anchor(top: nil, left: bottomView.leftAnchor, bottom: bottomView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 10, paddingRight: 0, width: 0, height: 20)
        
        let stackView = UIStackView(arrangedSubviews: [allButton, popularButton, makeupButton, haircutButton])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        bottomView.addSubview(stackView)
        stackView.anchor(top: bottomView.topAnchor, left: bottomView.leftAnchor, bottom: resultLabel.topAnchor, right: bottomView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 40)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
//    func statusBarHeight() -> CGFloat {
//        let statusBarSize = UIApplication.shared.statusBarFrame.size
//        return Swift.min(statusBarSize.width, statusBarSize.height)
//    }
}

