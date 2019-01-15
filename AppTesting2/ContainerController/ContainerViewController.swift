//
//  ContainerViewController.swift
//  AppTesting2
//
//  Created by Sovorn on 10/21/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit
import Firebase

class ContainerViewController: UIViewController{
    
    enum SlideOutState {
        case bothCollapsed
        case leftPanelExpanded
    }
    
    var centerNavigationController: UINavigationController!
    var centerViewController: ViewController!
    let centerPanelExpandedOffset: CGFloat = 250
    
    var currentState: SlideOutState = .bothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .bothCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    var leftViewController: LeftViewController?
    var login: Bool = false
    var phone: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    func setupController(){
        login = UserDefaults.standard.bool(forKey: "login")
        phone = UserDefaults.standard.string(forKey: "phone") ?? ""
        print(login)
        print(phone)
        if login {
            setupCenterController()
        } else {
            DispatchQueue.main.async {
                let loginController = UINavigationController(rootViewController: LoginController())
                self.present(loginController, animated: true)
            }
            return
        }
    }
    
    let edgePan = UIScreenEdgePanGestureRecognizer()
    
    func setupCenterController(){
        centerViewController = ViewController()
        centerViewController.delegate = self
        
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChild(centerNavigationController)
        centerNavigationController.didMove(toParent: self)
//        centerViewController.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:))))
        edgePan.addTarget(self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        view.addGestureRecognizer(edgePan)
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        let width = self.view.frame.width / 2
        let change = recognizer.translation(in: view).x
        switch recognizer.state {
        case .began:
            if currentState == .bothCollapsed {
                centerViewController.overlayView.alpha = 0.25
                addLeftPanelViewController()
                showShadowForCenterViewController(true)
                self.leftViewController?.view.frame = CGRect(x: -self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            }
        case .changed:
            self.leftViewController?.view.center.x = (self.leftViewController?.view.center.x)! + change <= -width + centerPanelExpandedOffset ? (self.leftViewController?.view.center.x)! + change : -width + centerPanelExpandedOffset
            recognizer.setTranslation(CGPoint.zero, in: view)
        case .ended:
            if (self.leftViewController?.view.center.x)! + change < -width + centerPanelExpandedOffset {
                let hasMoveGreaterThanHalfway = (leftViewController?.view.center.x)! > -(width) + (centerPanelExpandedOffset / 2)
                animateLeftPanel(shouldExpand: hasMoveGreaterThanHalfway)
            } else {
                currentState = .leftPanelExpanded
            }
            
        default:
            break
        }
    }
    
//    @objc func handlePanGesture(_ recongizer: UIPanGestureRecognizer){
//        let gestureIsDraggingFromLeftToRight = (recongizer.velocity(in: view).x > 0)
//
//        switch recongizer.state {
//        case .began:
//            if currentState == .bothCollapsed {
//                if gestureIsDraggingFromLeftToRight {
//                    centerViewController.overlayView.alpha = 0.25
//                    addLeftPanelViewController()
//                    showShadowForCenterViewController(true)
//                    self.leftViewController?.view.frame = CGRect(x: -self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//                }
//
//            }
//        case .changed:
//            if let rview = recongizer.view {
//                let width = self.view.frame.width / 2
////                let change = recongizer.translation(in: view).x
////                let leftCenterX = (self.leftViewController?.view.center.x)!
//                let rviewCenter = rview.center.x
//                rview.center.x = (rview.center.x + recongizer.translation(in: view).x) > width && (rviewCenter + recongizer.translation(in: view).x < width + centerPanelExpandedOffset) ? (rviewCenter + recongizer.translation(in: view).x) : rview.center.x
//                self.leftViewController?.view.center.x =  (self.leftViewController?.view.center.x)! + recongizer.translation(in: view).x < -width + centerPanelExpandedOffset ? (self.leftViewController?.view.center.x)! + recongizer.translation(in: view).x : (self.leftViewController?.view.center.x)!
//
//                
//            }
//        case .ended:
//            if let _ = leftViewController, let rview = recongizer.view {
//                let hasMoveGreaterThanHalfway = rview.center.x > (self.view.frame.width / 2) + (centerPanelExpandedOffset / 2)
//                animateLeftPanel(shouldExpand: hasMoveGreaterThanHalfway)
//            }
//
//        default:
//            break
//        }
//    }
}


extension ContainerViewController: ViewControllerDelegate, LeftDelegate{
//    func handleEdgePan(_ recognizer: UIScreenEdgePanGestureRecognizer) {
//        print("HAHA")
//        let width = self.view.frame.width / 2
//        let change = recognizer.translation(in: view).x
//        switch recognizer.state {
//        case .began:
//            self.leftViewController?.view.frame.origin.x = centerPanelExpandedOffset - self.view.frame.width
//        case .changed:
//            self.leftViewController?.view.center.x = (self.leftViewController?.view.center.x)! + change <= -width + centerPanelExpandedOffset ? (self.leftViewController?.view.center.x)! + change : -width + centerPanelExpandedOffset
//            recognizer.setTranslation(CGPoint.zero, in: view)
//        case .ended:
//            if (self.leftViewController?.view.center.x)! < -width + centerPanelExpandedOffset {
//                let hasMoveGreaterThanHalfway = (self.leftViewController?.view.center.x)! > -width + (centerPanelExpandedOffset / 2)
//                animateLeftPanel(shouldExpand: hasMoveGreaterThanHalfway)
//            } else {
//                currentState = .leftPanelExpanded
//            }
//            
//        default:
//            print("HAHA")
//        }
//    }
    
    func handleTapContainerLeftView(_ recognizer: UIPanGestureRecognizer) {
        let width = self.view.frame.width / 2
        let change = recognizer.translation(in: view).x
        switch recognizer.state {
        case .began:
            self.leftViewController?.view.frame.origin.x = centerPanelExpandedOffset - self.view.frame.width
        case .changed:
            self.leftViewController?.view.center.x = (self.leftViewController?.view.center.x)! + change <= -width + centerPanelExpandedOffset ? (self.leftViewController?.view.center.x)! + change : -width + centerPanelExpandedOffset
            recognizer.setTranslation(CGPoint.zero, in: view)
        case .ended:
            if (self.leftViewController?.view.center.x)! < -width + centerPanelExpandedOffset {
                let hasMoveGreaterThanHalfway = (self.leftViewController?.view.center.x)! > -width + (centerPanelExpandedOffset / 2)
                animateLeftPanel(shouldExpand: hasMoveGreaterThanHalfway)
            } else {
                currentState = .leftPanelExpanded
            }
            
        default:
            print("HAHA")
        }
    }
//    
//    func panLayerView(_ recognizer: UIPanGestureRecognizer){
//        let width = self.view.frame.width / 2
//        let change = recognizer.translation(in: view).x
//        switch recognizer.state {
//        case .began:
//            self.leftViewController?.view.frame.origin.x = centerPanelExpandedOffset - self.view.frame.width
//        case .changed:
//            self.leftViewController?.view.center.x = (self.leftViewController?.view.center.x)! + change <= -width + centerPanelExpandedOffset ? (self.leftViewController?.view.center.x)! + change : -width + centerPanelExpandedOffset
//            recognizer.setTranslation(CGPoint.zero, in: view)
//        case .ended:
//            if (self.leftViewController?.view.center.x)! < -width + centerPanelExpandedOffset {
//                let hasMoveGreaterThanHalfway = (self.leftViewController?.view.center.x)! > -width + (centerPanelExpandedOffset / 2)
//                animateLeftPanel(shouldExpand: hasMoveGreaterThanHalfway)
//            } else {
//                currentState = .leftPanelExpanded
//            }
//            
//        default:
//            print("HAHA")
//        }
//    }
    
    func tapLayerView() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func collapseSidePanels() {
        
    }
    
    func addLeftPanelViewController() {
        guard leftViewController == nil else {return}
        let vc = LeftViewController()
        vc.delegate = self
        vc.view.frame.origin.x = -self.view.frame.width
        addChildSidePanelController(vc)
        leftViewController = vc
    }
    
    func addChildSidePanelController(_ sidePanelController: LeftViewController) {
        view.addSubview(sidePanelController.view)
        addChild(sidePanelController)
        sidePanelController.didMove(toParent: self)
    }
    
    func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            centerViewController.overlayView.alpha = 0.25
            currentState = .leftPanelExpanded
            animateCenterPanelXPosition(targetPosition: centerPanelExpandedOffset)
        } else {
            centerViewController.overlayView.alpha = 0
            animateCenterPanelXPosition(targetPosition: 0) { (finished) in
                self.currentState = .bothCollapsed
                self.leftViewController?.view.removeFromSuperview()
                self.leftViewController = nil
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.leftViewController?.view.frame.origin.x = targetPosition - self.view.frame.width
//            self.centerViewController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func showShadowForCenterViewController(_ shouldShowShadow: Bool){
        if shouldShowShadow {
            leftViewController?.view.layer.shadowOpacity = 0.8
        } else {
            leftViewController?.view.layer.shadowOpacity = 0.0
        }
    }
}


