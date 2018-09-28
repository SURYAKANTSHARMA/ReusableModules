//
//  ViewController.swift
//  SKSideMenu
//
//  Created by SuryaKant Sharma on 28/04/18.
//  Copyright © 2018 SuryaKant Sharma. All rights reserved.
//

import UIKit

// MARK: -  Protocol
@objc
protocol ContainerControllerDelegate {
    @objc optional func toggleLeftPanel(callback: (() -> Void)?)
    @objc optional func collapseSidePanel(callback: (() -> Void)?)
    @objc optional func addChildVCWithSameNavigationController(viewController: UIViewController)
    @objc optional func addChildVCWithCustomNavigationController(viewController: UIViewController)
    @objc optional func pushOnTopOfTopMostVC(viewController: UIViewController)
    
}

protocol  MenuToggleProtocol {
    var menuDelegate : ContainerControllerDelegate? { get set}
}

class ContainerViewController: UIViewController {
    
    enum SlideOutState {
        case collasped
        case leftPanelExpanded
    }
    
    var currentlyShownNavigationController: UINavigationController!
    var currentlyShownViewController: UIViewController!
    var currentState: SlideOutState = .collasped {
        didSet {
            switch currentState {
            case .leftPanelExpanded:
                self.showShadowForCenterViewController(true)
            case .collasped:
                break
            }
        }
    }
    var leftViewController: SideMenuViewController?
    var rightViewController: UIViewController?
    let centerPanelExpandedOffset: CGFloat = 125
    var blackView: BlackContainerView?
    let language: LanguageType = Localize.currentLanguage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true 
        setUpIntialVC()
    }
    
  
    fileprivate func makeDelegateToSelf() {
        if var menuToggleProtocol = currentlyShownViewController as? MenuToggleProtocol {
            menuToggleProtocol.menuDelegate  = self
        }
       
        /*
         special case in case embedded UIViewController can be UITabViewController so the special case to be Handled in the way
         **/
        if let currentlyShownTabViewController = currentlyShownViewController as? UITabBarController {
            for childVC in currentlyShownTabViewController.children {
                print(type(of: childVC.self))
                if let navVC =  childVC as? UINavigationController, let rootVC = navVC.children.first,
                    var hadImplementMenuToggleProtocol = rootVC as? MenuToggleProtocol {
                    hadImplementMenuToggleProtocol.menuDelegate = self
                }
            }
        }
    }
    
    func setUpIntialVC() {
        currentlyShownViewController = UIStoryboard.home.instantiateViewController(withIdentifier: String(describing: "HomeTabController"))
        makeDelegateToSelf()
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        currentlyShownNavigationController = UINavigationController(rootViewController: currentlyShownViewController)
        if currentlyShownViewController is UITabBarController {
            currentlyShownNavigationController.navigationBar.isHidden = true
        }
        switch language {
        case .english, .espanol:
            currentlyShownNavigationController?.view.semanticContentAttribute = .forceLeftToRight
            currentlyShownNavigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
        case .arabic:
            currentlyShownNavigationController?.view.semanticContentAttribute = .forceRightToLeft
            currentlyShownNavigationController?.navigationBar.semanticContentAttribute = .forceRightToLeft
        }
        addNavigationInContainerAsChild()
    }
    
    func addNavigationInContainerAsChild() {
        view.addSubview(currentlyShownNavigationController.view)
        addChild(currentlyShownNavigationController)
        currentlyShownNavigationController.didMove(toParent: self)
    }
    

    
    func removeNavigationFromContainer() {
        currentlyShownNavigationController?.view.removeFromSuperview()
        currentlyShownNavigationController.removeFromParent()
        currentlyShownNavigationController = nil
    }
    
    
    func addChildVCWithSameNavigationController(viewController: UIViewController) {
        collapseSidePanel()
//        currentlyShownViewController = viewController
//        makeDelegateToSelf()
//        if let currentlyShownNavigationController = currentlyShownNavigationController, currentlyShownNavigationController.viewControllers.count > 0 {
//            self.currentlyShownNavigationController?.viewControllers.removeAll()
//            self.currentlyShownNavigationController?.viewControllers = [currentlyShownViewController]
//        }
        // navigate to home VC
        removeNavigationFromContainer()
        setUpIntialVC()
    }
    
    func addChildVCWithCustomNavigationController(viewController: UIViewController) {
        collapseSidePanel()
        removeNavigationFromContainer()
        currentlyShownNavigationController = UINavigationController(rootViewController: viewController)
        currentlyShownViewController = viewController
        makeDelegateToSelf()
        addNavigationInContainerAsChild()
    }
    
    func pushOnTopOfTopMostVC(viewController: UIViewController) {
        collapseSidePanel {
            if var viewController = viewController as? MenuToggleProtocol {
                viewController.menuDelegate = self
            }
            self.currentlyShownNavigationController.push(viewController: viewController)
        }
    }
}


// MARK: - ContainerControllerDelegate
extension ContainerViewController: ContainerControllerDelegate {
    func toggleLeftPanel(callback: (() -> Void)? = nil) {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpanded, callback: callback)
    }
    
    func collapseSidePanel(callback: (() -> Void)? = nil) {
        switch currentState {
        case .leftPanelExpanded:
            toggleLeftPanel(callback: callback)
        default:
            break
        }
    }
    
    func addLeftPanelViewController() {
          guard leftViewController == nil else { return }
          let leftMenuVC: SideMenuViewController = UIStoryboard.instantiateViewController(type: .homeTab)
          leftMenuVC.menuDelegate  = self
          addChildSidePanelController(leftMenuVC)
          leftViewController = leftMenuVC
    }
    
    
    func addChildSidePanelController(_ sidePanelController: UIViewController) {
        //sidePanelController.delegate = centerViewController
        view.insertSubview(sidePanelController.view, at: 0)
        addChild(sidePanelController)
        sidePanelController.didMove(toParent: self)
    }
    
    func removeChildSidePanelController(_ sidePanelController: inout UIViewController?) {
        sidePanelController?.view.removeFromSuperview()
        sidePanelController?.removeFromParent()
        sidePanelController = nil
    }
    
    func animateLeftPanel(shouldExpand: Bool, callback: (() -> Void)? = nil) {
        if shouldExpand {
            // reload the view always
            leftViewController?.reloadView()
            currentState = .leftPanelExpanded
            animateCenterPanelXPosition(
                targetPosition: currentlyShownNavigationController.view.frame.width - centerPanelExpandedOffset)
            addBlackViewOnNavigation()
            
        } else {
            //remove black view if exist
            blackView?.removeFromSuperview()
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .collasped
                callback?()
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut, animations: {
                       switch self.language {
                        case .english, .espanol:
                            self.currentlyShownNavigationController.view.frame.origin.x = targetPosition
                        case .arabic:
                            self.currentlyShownNavigationController.view.frame.origin.x = -targetPosition
                        }
                        
        }, completion: completion)
    }
    
    func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
        if shouldShowShadow {
            currentlyShownNavigationController?.view.layer.shadowOpacity = 1
            currentlyShownNavigationController?.view.layer.shadowRadius = 5
        } else {
            currentlyShownNavigationController?.view.layer.shadowOpacity = 0.0
            currentlyShownNavigationController?.view.layer.shadowRadius = 0
        }
    }
    
    func addBlackViewOnNavigation() {
        blackView = BlackContainerView(frame: UIScreen.main.bounds) {
            self.collapseSidePanel()
        }
        blackView?.blackAlpha = 0.1
        if let blackView = blackView {
            currentlyShownNavigationController?.view.addSubview(blackView)
        }
    }
}



