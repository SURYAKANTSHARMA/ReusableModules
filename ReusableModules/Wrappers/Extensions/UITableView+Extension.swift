//
//  UITableView+Extension.swift
//  YoGrowcerCustomer
//
//  Created by IOS Developer on 15/05/18.
//  Copyright © 2018 SuryaKant Sharma. All rights reserved.
//

import UIKit

// MARK:-  TableView

extension  UITableView {
    
    func hideEmptyCellSeprators() {
        tableFooterView = UIView()
    }
    
    func scrollEnabledOnlyExtraContent() {
        if (self.contentSize.height > self.frame.size.height) {
            self.isScrollEnabled = true;
        } else {
            self.isScrollEnabled = false;
        }
    }
    
    func registerCell(_ nibName: String, identifier: String = "", bundle: Bundle? = nil ) {
        var identifier = identifier
        if (identifier.isEmpty || identifier.length <= 0){
            identifier = nibName;
        }
        let nib: UINib = UINib(nibName: nibName, bundle: bundle);
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func registerHeaderFooter(_ nibName: String, identifier: String = "", bundle: Bundle? = nil ) {
        var identifier = identifier
        if (identifier.isEmpty || identifier.length <= 0){
            identifier = nibName;
        }
        let nib: UINib = UINib(nibName: nibName, bundle: bundle);
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func addActivityIndicationAtTableFooter() {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = UIColor.Application.darkThemeColor
        activityIndicator.startAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: frame.width, height: 50)
        tableFooterView = activityIndicator
        self.contentOffset = CGPoint(x: contentOffset.x, y: contentOffset.y + activityIndicator.frame.size.height)
    }
    
    func removeActivityIndicatorFromFooter() {
        tableFooterView = nil
    }
    
    func scrollToTop() {
        guard !isHidden else {
            return
        }
        if #available(iOS 11.0, *) {
            performBatchUpdates({
                setContentOffset(CGPoint.zero, animated: false)
            }, completion: nil)
        } else {
            // Fallback on earlier versions
            beginUpdates()
            setContentOffset(CGPoint.zero, animated: false)
            endUpdates()
        }
    }
    
    func scrollToBottom(animated: Bool = true) {
        let y = contentSize.height - frame.size.height
        setContentOffset(CGPoint(x: 0, y: (y<0) ? 0 : y), animated: animated)
    }
    
    func defaultHeader(text: String) -> UIView {
        // Simple Header View Use in most of tableViews
                let headerView: UIView = {
                    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 30))
                    let headingLabel = UILabel(frame: CGRect(x: 20, y: headerView.frame.height/2 - 10, width: UIScreen.main.bounds.width, height: 20))
                    headingLabel.font = UIFont.Application.fontSemiBold(size: 14)
                    headingLabel.text = text
                    headerView.addSubview(headingLabel)
                    headingLabel.translatesAutoresizingMaskIntoConstraints = false
                    headingLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
                    headingLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 8).isActive = true
                    headingLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
                    return headerView
                }()
        return headerView
    }
    
    func deleteRowAt(indexPath: IndexPath, animation: UITableView.RowAnimation = .automatic) {
        beginUpdates()
        deleteRows(at: [indexPath], with: animation)
        endUpdates()
    }
    
    func reloadSection(atIndex: Int, animation: UITableView.RowAnimation = .automatic) {
        beginUpdates()
        reloadSections(IndexSet([atIndex]), with: animation)
        endUpdates()
    }
}

extension UITableViewCell {
    func defaultSetUp() {
      selectionStyle = .none
    }
}

