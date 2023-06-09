//
//  AuthViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit

class AuthViewController: UIViewController {
    
    let usernameField: TextField = {
        let textField = TextField()
        textField.placeholder = "Username"
        return textField
    }()
    
    let passwordField: TextField = {
        let textField = TextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let signInButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Sign In", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()

    func setup() {
        view.backgroundColor = .white
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationItem.title = "Welcome back!"
        signInButton.addTarget(self, action: #selector(signIn(_:)), for: .touchUpInside)
        
        stackView.addArrangedSubview(usernameField)
        stackView.addArrangedSubview(passwordField)
        
        view.addSubview(stackView)
        view.addSubview(signInButton)
        
        [usernameField, passwordField, stackView, signInButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: h * CGFloat(140/844.0)),
            
            usernameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            usernameField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            usernameField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            passwordField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            passwordField.heightAnchor.constraint(equalToConstant: 48),
            
            signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            signInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            signInButton.heightAnchor.constraint(equalToConstant: 54),
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -h * CGFloat(50/844.0))
        ])
    }
}

extension AuthViewController {
    @objc func signIn(_ sender: UIButton) {
        print(usernameField.text)
        print(passwordField.text)
    }
}
