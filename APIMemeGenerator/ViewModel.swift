//
//  ViewModel.swift
//  APIMemeGenerator
//
//  Created by Josicleison on 01/10/22.
//

import UIKit

class ViewModel {
    
    func createTextField(_ placeholder: String,
                         font: UIFont? = App.font) -> UITextField {
        
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = font
        textField.layer.cornerRadius = 5
        
        let attributedPlaceholder = NSAttributedString(
            
            string: placeholder,
            attributes: [
                
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ]
        )
        
        textField.attributedPlaceholder = attributedPlaceholder
        
        return textField
    }
}
