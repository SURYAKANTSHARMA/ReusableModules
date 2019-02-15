//
//  SideMenuViewController.swift
//  Rider
//
//  Created by Mac mini on 8/16/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import UIKit

enum MenuItemType: Int, CaseCountable {
    
    case home
    case booking
    case wallet
    case contactUs
    case aboutUs
    case termAndCondition
    case logout
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .booking: return "My Rides"
        case .wallet: return "Wallet"
        case .contactUs: return "Contact Us"
        case .aboutUs: return "About Us"
        case .termAndCondition : return  "Term & Conditions"
        case .logout: return "Log out"
        }
    }
}

class SideMenuViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func fetchProfile() {
     
    }
    
    func updateProfileView() {
    }
    
    func initialSetUp() {
    }
    
    func reloadView() {
        
     }
    
   
}

