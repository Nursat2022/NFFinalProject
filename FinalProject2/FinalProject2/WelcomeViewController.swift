//
//  WelcomeViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 05.06.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    lazy var vectorImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Welcome to the biggest sneakers store app"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .center
        return stackView
    }()
    
    let SignUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 27
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return button
    }()
    
    let firstImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let secondImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let SignInButton: UIButton = {
        let button = UIButton()
        button.setTitle("I already have an account", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        vectorImage.image = UIImage(named: "vector4")
        firstImage.image = UIImage(named: "image7")
        secondImage.image = UIImage(named: "image8")
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(SignUpButton)
        stackView.addArrangedSubview(SignInButton)
        
        view.addSubview(vectorImage)
        view.addSubview(firstImage)
        view.addSubview(secondImage)
        view.addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            vectorImage.topAnchor.constraint(equalTo: view.topAnchor),
            
            firstImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            firstImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            secondImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            secondImage.bottomAnchor.constraint(equalTo: firstImage.bottomAnchor, constant: -50),

            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            
            SignUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            SignUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            SignUpButton.heightAnchor.constraint(equalToConstant: 54),
            
            SignInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36),
            SignInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -36),
        ])
    }
}
