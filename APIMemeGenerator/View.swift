//
//  View.swift
//  APIMemeGenerator
//
//  Created by Josicleison on 01/10/22.
//

import UIKit

class View: UIViewController {
    
    private let netWork = NetWork()
    
    private lazy var stack: UIStackView = {
        
        let font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        let createTextField = {(placeholder: String) -> UITextField in
            
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
        
        let textFields = [createTextField("Top"),
                          createTextField("Bottom"),
                          createTextField("Meme")]
        
        let textFieldsStack = UIStackView(arrangedSubviews: textFields)
        textFieldsStack.spacing = 5
        textFieldsStack.distribution = .fillEqually
        
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.titleLabel?.font = font
        
        let action = UIAction{_ in
            
            self.netWork.requestMeme(top: textFields[0].text,
                                     bottom: textFields[1].text,
                                     meme: textFields[2].text) {data in
                
                self.imageView.image = UIImage(data: data)
            }
        }
        
        button.addAction(action, for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [textFieldsStack, button])
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 10,
                                           left: 10,
                                           bottom: 10,
                                           right: 10)
        stack.axis = .vertical
        
        return stack
    }()
    
    private lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        netWork.requestMeme {data in
            
            imageView.image = UIImage(data: data)
        }
        
        return imageView
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubviews([imageView, stack])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

