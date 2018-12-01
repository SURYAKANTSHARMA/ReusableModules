//
//  UICollectionView+Extension.swift
//  YoGrowcerCustomer
//
//  Created by IOS Developer on 15/05/18.
//  Copyright © 2018 SuryaKant Sharma. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func cellForItem<T>(_ indexPath: IndexPath) -> T {
        guard let cell = cellForItem(at: indexPath) as? T else {
            fatalError("The cell of \(T.self) not type cast from UICollectionCell")
        }
        return cell
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            print("Could not dequeue cell with identifier: \(String(describing: T.self))")
            fatalError("Could not dequeue cell with identifier: \(String(describing: T.self))")
        }
        return cell
    }
    
    func registerCell(_ nibName: String, identifier: String = "", bundle: Bundle? = nil ) {
        var identifier = identifier
        if (identifier.isEmpty || identifier.length <= 0){
            identifier = nibName
        }
        let nib: UINib = UINib(nibName: nibName, bundle: bundle)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func registerHeader(_ nibName: String, identifier: String = "", bundle: Bundle? = nil ) {
        var identifier = identifier
        if (identifier.isEmpty || identifier.length <= 0) {
            identifier = nibName
        }
        let nib: UINib = UINib(nibName: nibName, bundle: bundle)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier)
    }
    
    func registerFooter(_ nibName: String, identifier: String = "", bundle: Bundle? = nil ) {
        var identifier = identifier
        if (identifier.isEmpty || identifier.length <= 0) {
            identifier = nibName
        }
        let nib: UINib = UINib(nibName: nibName, bundle: bundle)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier)
    }
    
}
