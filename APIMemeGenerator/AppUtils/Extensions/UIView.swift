//
//  UIView.swift
//  APIMemeGenerator
//
//  Created by Josicleison on 01/10/22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        
        for view in views {
            
            self.addSubview(view)
        }
    }
}
