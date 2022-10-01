//
//  View.swift
//  APIMemeGenerator
//
//  Created by Josicleison on 01/10/22.
//

import UIKit

class View: UIViewController {
    
    let netWork = NetWork()
    let viewModel = ViewModel()
    
    private let imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    private lazy var textFields = [viewModel.createTextField("Top"),
                                   viewModel.createTextField("Bottom"),
                                   viewModel.createTextField("Meme")]
    
    private lazy var stack: UIStackView = {
        
        let textFieldsStack = UIStackView(arrangedSubviews: textFields)
        textFieldsStack.spacing = 5
        textFieldsStack.distribution = .fillEqually
        
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.titleLabel?.font = App.font
        
        let action = UIAction{_ in
            
            button.isEnabled = false
            button.setTitleColor(.black, for: .normal)
            
            self.netWork.requestMeme(top: self.textFields[0].text,
                                     bottom: self.textFields[1].text,
                                     meme: self.textFields[2].text) {data in
                
                button.isEnabled = true
                button.setTitleColor(.white, for: .normal)
                
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
    
    private lazy var scrollView: UIScrollView = {
        
        let createButtons = {(texts: [String]) -> [UIButton] in
            
            var buttons: [UIButton] = []
            
            for text in texts {
                
                let button = UIButton()
                button.setTitle(text, for: .normal)
                button.titleLabel?.font = App.smallFont
                
                let action = UIAction{_ in
                    
                    self.textFields[2].text = button.currentTitle
                }
                
                button.addAction(action, for: .touchUpInside)
                
                buttons.append(button)
            }
            
            return buttons
        }
        
        let stackToScroll = UIStackView(arrangedSubviews: createButtons(netWork.memes))
        stackToScroll.axis = .vertical
        stackToScroll.alignment = .leading
        
        let scrollView = UIScrollView()
        scrollView.addSubview(stackToScroll)
        
        stackToScroll.translatesAutoresizingMaskIntoConstraints = false
        
        stackToScroll.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        stackToScroll.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        stackToScroll.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        stackToScroll.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        stackToScroll.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        
        return scrollView
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubviews([imageView, stack, scrollView])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: stack.topAnchor).isActive = true
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

