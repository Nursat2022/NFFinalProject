//
//  RegistrationViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    let SignUpButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Sign up", for: .normal)
        return button
    }()
    
    let usernameField: TextField = {
        let textField = TextField()
        textField.placeholder = "Username"
        return textField
    }()
    
    let passwordField: TextField = {
        let textField = TextField()
        textField.placeholder = "Password"
        return textField
    }()
    
    let repeatField: TextField = {
        let textField = TextField()
        textField.placeholder = "Repeat password"
        return textField
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = .white
        
        [usernameField, passwordField, repeatField, stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.barTintColor = .black
        self.title = "New User"
        
        SignUpButton.addTarget(self, action: #selector(submit(_:)), for: .touchUpInside)
        
        stackView.addArrangedSubview(usernameField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(repeatField)
        
        view.addSubview(stackView)
        view.addSubview(SignUpButton)
        
        NSLayoutConstraint.activate([
            usernameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            usernameField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            usernameField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            passwordField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            passwordField.heightAnchor.constraint(equalToConstant: 48),
            
            repeatField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            repeatField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            repeatField.heightAnchor.constraint(equalToConstant: 48),
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            
            SignUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            SignUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            SignUpButton.heightAnchor.constraint(equalToConstant: 54),
            SignUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
}

extension RegistrationViewController {
    @objc func submit(_ sender: UIButton) {
        print(usernameField.text)
        print(passwordField.text)
    }
}
