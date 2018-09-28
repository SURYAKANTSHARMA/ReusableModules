//
//  BaseViewController.swift
//  YoGrowcerCustomer
//
//  Created by IOS Developer on 08/05/18.
//  Copyright © 2018 SuryaKant Sharma. All rights reserved.
//

import UIKit
import SafariServices

// TODO : - Conform to protocol MenuToggleProtocol
class BaseViewController: UIViewController, UIGestureRecognizerDelegate, MenuToggleProtocol {
    // MARK:-  Menu Delegate and Action Basic
   weak var menuDelegate: ContainerControllerDelegate?
    /**
     *  black View for make view disable
     */
    var blackView: UIView!
    fileprivate var frameOfImageView: CGRect!
    
    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    /**
     *  noDataLabel shows in center of screen with message text if data from server is not available for particular case
     */
    var noDataLabel = UILabel()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setUpDefaultNavigationConfig()
    }
    
    func addLeftMenuInNavigationItem() {
        let menuitem = UIBarButtonItem(image: UIImage(named: "icn-menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(menuButtonTapped(button:)))
        self.navigationItem.leftBarButtonItem = menuitem
    }
    
    
    @objc func menuButtonTapped(button: UIButton) {
        menuDelegate?.toggleLeftPanel?(callback: nil)
    }
    /**
     *  add the view e.g add(CustomView.Self)
     */
    @discardableResult
    func add<T: UIView>(view: T.Type, frame: CGRect? = nil) -> T {
        guard let nib: T = UIView.loadNib() else {
            fatalError("Unable to load View: \(T.description())")
        }
        if let frame = frame {
            nib.frame = frame
        }
        print(nib.frame)
        nib.addShadowView()
        blackView =  UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        blackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removePresentedView(_:)))
        tapGesture.delegate = self
        blackView.addGestureRecognizer(tapGesture)
        
        blackView.addSubview(nib)
        self.view.addSubview(blackView)
        nib.center = CGPoint(x: blackView.center.x, y: blackView.center.y - topbarHeight)
        self.view.bringSubviewToFront(blackView)
        blackView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.6, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.blackView.transform = CGAffineTransform.identity
        }, completion: nil)
        return nib
    }
    
    /**
     *  remove view from self on tap on black View
     */
    @objc func removePresentedView(_ sender: UIGestureRecognizer) {
        _ = self.blackView?.subviews.forEach  { $0.removeFromSuperview() }
        self.blackView?.removeFromSuperview()
        
    }
    /**
     *  remove view from self manually
     */
    func removePresentedView() {
        _ = self.blackView?.subviews.forEach  { $0.removeFromSuperview() }
        self.blackView?.removeFromSuperview()
    }
    /**
     *  Function For make imageView Full Screen visible and then hide on double tap
     */
    @objc func imageTapped(_ sender: UITapGestureRecognizer)  {
        
        let imageView = sender.view as! UIImageView
        frameOfImageView = imageView.frame
        let newImage = UIImageView(image: imageView.image)
        newImage.frame = UIScreen.main.bounds
        newImage.backgroundColor = UIColor.black
        newImage.contentMode = .scaleAspectFit
        newImage.isUserInteractionEnabled = true
        
        //navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissFullScreenImage(_:)))
        newImage.addGestureRecognizer(tapGesture)
        view.backgroundColor = .white
        view.addSubview(newImage)
        
        let deltaX = view.center.x - imageView.center.x
        let deltaY = view.center.y - imageView.center.y
        print("before Transformation \(newImage.frame) dx: \(deltaX) dy\(deltaY )")
        newImage.transform = CGAffineTransform(scaleX: 0, y: 0).translatedBy(x: -deltaX, y: -deltaY)
        print("After Transformation \(newImage.frame)")
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.1, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            newImage.transform = CGAffineTransform.identity
        }, completion: nil)
        
        
    }
    
    @objc fileprivate func dismissFullScreenImage(_ sender: UITapGestureRecognizer) {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.6, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            sender.view?.transform = CGAffineTransform(scaleX: 0, y: 0)
        }, completion: { animated in
            sender.view?.removeFromSuperview()
        })
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == blackView {
            return true
        }
        return false 
    }
    
    func addNoDataAvailable(message: String) {
        noDataLabel.isHidden = false
        noDataLabel.text = message
        noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        noDataLabel.numberOfLines = 0
        noDataLabel.textAlignment = .center
        view.addSubview(noDataLabel)
        
        if #available(iOS 11.0, *) {
            noDataLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
            noDataLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 8).isActive = true
            noDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
        } else {
            // Fallback on earlier versions
            noDataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
            noDataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8).isActive = true
            noDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
    
    func share(text: String) {
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        // so that iPads won't crash
        activityVC.popoverPresentationController?.sourceView = view
        // exclude some activity types from the list (optional)
        activityVC.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        // present the view controller
        self.present(activityVC, animated: true, completion: nil)
    }
    
}

// MARK: - SFSafariViewControllerDelegate
extension BaseViewController: SFSafariViewControllerDelegate {
    public func presentSafariController(url: URL) {
        let sfSafariController = SFSafariViewController(url: url)
        sfSafariController.delegate = self
        present(sfSafariController, animated: true, completion: nil)
    }
}


