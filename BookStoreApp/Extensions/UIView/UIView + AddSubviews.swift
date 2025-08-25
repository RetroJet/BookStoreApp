//
//  UIView.swift
//  BookStoreApp
//
//  Created by Nazar on 06.08.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

