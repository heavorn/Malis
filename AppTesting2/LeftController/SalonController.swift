//
//  Salon.swift
//  AppTesting2
//
//  Created by Sovorn on 10/24/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

class SalonController: UITableViewController {
    
    let cellId = "cellId"
    
    var salons = [Salon]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SalonCell
        cell.salon = self.salons[indexPath.item]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let plusController = PlusSalonController()
        plusController.salon = salons[indexPath.item]
        plusController.uploadButton.isHidden = true
        plusController.editButton.isHidden = false
        plusController.isEdit = true
        let navController = UINavigationController(rootViewController: plusController)
        present(navController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSalon()
        tableView.backgroundColor = .white
        tableView.register(SalonCell.self, forCellReuseIdentifier: cellId)
        navigationController?.navigationBar.tintColor = .mainColor()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(handleBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(handleAdd))
    }
    
    private func fetchSalon(){
        let ref = Database.database().reference().child("salon")
        ref.observe(.childAdded, with: { (snapshot) in
            ref.child(snapshot.key).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dic = snapshot.value as? [String: String] {
                    let salon = Salon(dic: dic)
                    self.salons.append(salon)
                }
                self.tableView.reloadData()
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    let addImage: UIImage = {
        var image = UIImage(named: "icon_add")
        image = image?.imageWithColor(color1: .mainColor())
        
        return image!
    }()
    
    @objc func handleAdd(){
        let plusController = PlusSalonController()
        plusController.profile.isUserInteractionEnabled = true
        plusController.photo1.isUserInteractionEnabled = true
        plusController.photo2.isUserInteractionEnabled = true
        plusController.photo3.isUserInteractionEnabled = true
        plusController.photo4.isUserInteractionEnabled = true
        plusController.photo5.isUserInteractionEnabled = true
        plusController.photo6.isUserInteractionEnabled = true
        plusController.photo7.isUserInteractionEnabled = true
        plusController.photo8.isUserInteractionEnabled = true
        plusController.photo9.isUserInteractionEnabled = true
        plusController.photo10.isUserInteractionEnabled = true
        
        plusController.nameTextField.isEnabled = true
        plusController.serviceTextField.isEnabled = true
        plusController.priceTextField.isEnabled = true
        plusController.discountTextField.isEnabled = true
        plusController.phoneTextField.isEnabled = true
        plusController.descriptionTextField.isEnabled = true
        
        
        let navController = UINavigationController(rootViewController: plusController)
        present(navController, animated: true)
    }
    
    let backImage: UIImage = {
        var image = UIImage(named: "icon_back")
        image = image?.imageWithColor(color1: .mainColor())
        
        return image!
    }()
    
    @objc func handleBack(){
        guard let containerController = UIApplication.shared.keyWindow?.rootViewController as? ContainerViewController else {return}
        containerController.currentState = .bothCollapsed
        containerController.leftViewController?.view.removeFromSuperview()
        containerController.leftViewController = nil
        containerController.setupController()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
    }
}
