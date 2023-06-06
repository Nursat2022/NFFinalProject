//
//  RegistrationViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    var usernameField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Username"
        textField.tintColor = UIColor.black
        textField.layer.cornerRadius = 4
        textField.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        return textField
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
    
    var passwordField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.tintColor = UIColor.black
        textField.layer.cornerRadius = 4
        textField.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        return textField
    }()
    
    var repeatField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Repeat password"
        textField.tintColor = UIColor.black
        textField.layer.cornerRadius = 4
        textField.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        return textField
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
