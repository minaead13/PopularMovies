//
//  UICollectionView.swift
//  MoviesApp
//
//  Created by OSX on 25/08/2025.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func registerCell<Cell: UICollectionViewCell>(cell: Cell.Type) {
        let nibName = String(describing: cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(identifier)")
        }
        return cell
    }
}
