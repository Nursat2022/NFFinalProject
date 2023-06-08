//
//  RegistrationViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit

var data = ["username": "Nursat", "password": "hello"]

class AccountViewController: UIViewController {
    
    let SaveButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Save changes", for: .normal)
        return button
    }()
    
    let usernameField: TextField = {
        let textField = TextField()
        textField.text = data["username"]
        return textField
    }()
    
    let oldPassword: TextField = {
        let textField = TextField()
        textField.placeholder = "old password"
        return textField
    }()
    
    let repeatField: TextField = {
        let textField = TextField()
        textField.placeholder = "new password"
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
        
        [usernameField, oldPassword, repeatField, stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.barTintColor = .black
        self.title = "Account Information"
        
        SaveButton.addTarget(self, action: #selector(submit(_:)), for: .touchUpInside)
        
        stackView.addArrangedSubview(usernameField)
        stackView.addArrangedSubview(oldPassword)
        stackView.addArrangedSubview(repeatField)
        
        view.addSubview(stackView)
        view.addSubview(SaveButton)
        
        NSLayoutConstraint.activate([
            usernameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            usernameField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            usernameField.heightAnchor.constraint(equalToConstant: 48),
            
            oldPassword.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            oldPassword.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            oldPassword.heightAnchor.constraint(equalToConstant: 48),
            
            repeatField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            repeatField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            repeatField.heightAnchor.constraint(equalToConstant: 48),
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 104),
            
            SaveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            SaveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            SaveButton.heightAnchor.constraint(equalToConstant: 54),
            SaveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
}

extension AccountViewController {
    @objc func submit(_ sender: UIButton) {
        print(usernameField.text)
        print(oldPassword.text)
    }
}
