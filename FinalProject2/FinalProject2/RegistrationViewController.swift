//
//  RegistrationViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {
    
    let stateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 15)
        label.isHidden = true
        return label
    }()
    
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
        
        [usernameField, passwordField, repeatField, stackView, stateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationItem.title = "New User"
        
        SignUpButton.addTarget(self, action: #selector(submit(_:)), for: .touchUpInside)
        
        stackView.addArrangedSubview(usernameField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(repeatField)
        
        view.addSubview(stackView)
        view.addSubview(SignUpButton)
        view.addSubview(stateLabel)
        
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
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: h * CGFloat(140/844.0)),
            
            SignUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            SignUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            SignUpButton.heightAnchor.constraint(equalToConstant: 54),
            SignUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -h * CGFloat(50/844.0)),
            
            stateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension RegistrationViewController {
    @objc func submit(_ sender: UIButton) {
        stateLabel.isHidden = false
        guard let email = usernameField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty,
              let repeatPass = repeatField.text, !repeatPass.isEmpty else {
            stateLabel.text = "some fields are empty"
            return
        }
        
        guard password == repeatField.text else {
            stateLabel.text = "repeat the password correctly"
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email + "@gmail.com", password: password) {[weak self] result, error in
            guard let strongSelf = self else { return }
            guard error == nil else {
                strongSelf.stateLabel.text = "A user with this name already exists"
                return
            }
            
            let transition = CATransition()
            transition.duration = 0.1
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight

            UIApplication.shared.keyWindow?.layer.add(transition, forKey: nil)
            UIApplication.shared.keyWindow?.rootViewController = TabBarController()
        }
    }
}
