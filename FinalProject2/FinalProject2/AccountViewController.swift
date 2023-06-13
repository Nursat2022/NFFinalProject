//
//  RegistrationViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountViewController: UIViewController, UITextFieldDelegate {
    
    let stateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()
    
    let SaveButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Save changes", for: .normal)
        return button
    }()
    
    let usernameField: TextField = {
        let textField = TextField()
        textField.text = getUserName()
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let oldPassword: TextField = {
        let textField = TextField()
        textField.placeholder = "old password"
        return textField
    }()
    
    let newPassword: TextField = {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = .white
        [usernameField, oldPassword, newPassword].forEach {
            $0.delegate = self
        }
        [usernameField, oldPassword, newPassword, stackView, stateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        stateLabel.isHidden = true
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.barTintColor = .black
        self.title = "Account Information"
        
        SaveButton.addTarget(self, action: #selector(submit(_:)), for: .touchUpInside)
        
        stackView.addArrangedSubview(usernameField)
        stackView.addArrangedSubview(oldPassword)
        stackView.addArrangedSubview(newPassword)
        
        view.addSubview(stackView)
        view.addSubview(SaveButton)
        view.addSubview(stateLabel)
        
        NSLayoutConstraint.activate([
            usernameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            usernameField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            usernameField.heightAnchor.constraint(equalToConstant: 48),
            
            oldPassword.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            oldPassword.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            oldPassword.heightAnchor.constraint(equalToConstant: 48),
            
            newPassword.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            newPassword.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            newPassword.heightAnchor.constraint(equalToConstant: 48),
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: h * CGFloat(104/844.0)),
            
            SaveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            SaveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            SaveButton.heightAnchor.constraint(equalToConstant: 54),
            SaveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -h * CGFloat(100/844.0)),
            
            stateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension AccountViewController {
    @objc func submit(_ sender: UIButton) {
        stateLabel.isHidden = false
        guard let oldPassword = oldPassword.text, !oldPassword.isEmpty else {
            stateLabel.text = "some fields are empty"
            stateLabel.textColor = .red
            return
        }
        guard let newPassword = newPassword.text, !newPassword.isEmpty else {
            stateLabel.text = "some fields are empty"
            stateLabel.textColor = .red
            return
        }

        guard let user = Auth.auth().currentUser else { return }
        let credential = EmailAuthProvider.credential(withEmail: user.email!, password: oldPassword)
        user.reauthenticate(with: credential) { result, error in
            let loader = loader(viewController: self)
            guard error == nil else {
                self.stateLabel.text = "wrong old password"
                self.stateLabel.textColor = .red
                stopLoader(loader: loader)
                return
            }
            user.updatePassword(to: newPassword) { error in
                guard error == nil else {
                    self.stateLabel.text = "error"
                    self.stateLabel.textColor = .red
                    stopLoader(loader: loader)
                    return
                }
                self.stateLabel.text = "changed successfully"
                self.stateLabel.textColor = .green
                stopLoader(loader: loader)
            }
        }
    }
//    @objc func submit(_ sender: UIButton) {
//        stateLabel.isHidden = false
//        guard let user = Auth.auth().currentUser else { return }
//
//        guard let newUsername = self.usernameField.text, !newUsername.isEmpty else {
//            self.stateLabel.text = "enter valid email"
//            self.stateLabel.textColor = .red
//            return
//        }
//        if newUsername != user.email! {
//            if newPassword.text!.isEmpty && oldPassword.text!.isEmpty {
//                let loader = loader(viewController: self)
//                user.updateEmail(to: newUsername + "@gmail.com") { error in
//                    guard error != nil else {
//                        self.stateLabel.text = "user with this email already exists"
//                        return
//                    }
//                    self.stateLabel.text = "Changed successfully"
//                    self.stateLabel.textColor = .green
//                    stopLoader(loader: loader)
//                }
//            }
//        }
//
//        guard let oldPassword = oldPassword.text, !oldPassword.isEmpty else {
//            stateLabel.text = "some fields are empty"
//            stateLabel.textColor = .red
//            return
//        }
//        guard let newPassword = newPassword.text, !newPassword.isEmpty else {
//            stateLabel.text = "some fields are empty"
//            stateLabel.textColor = .red
//            return
//        }
//
//        let credential = EmailAuthProvider.credential(withEmail: user.email!, password: oldPassword)
//        user.reauthenticate(with: credential) { result, error in
//            let loader = loader(viewController: self)
//            guard error == nil else {
//                self.stateLabel.text = "wrong old password"
//                self.stateLabel.textColor = .red
//                stopLoader(loader: loader)
//                return
//            }
//            user.updatePassword(to: newPassword) { error in
//                guard error == nil else { return }
//                self.stateLabel.text = "Changed successfully"
//                self.stateLabel.textColor = .green
//                stopLoader(loader: loader)
//            }
//        }
//    }
}

func getUserName() -> String {
    let email = Auth.auth().currentUser?.email!
    let atIndex = email!.firstIndex(of: "@")
    let username = email![..<atIndex!]
    let usernameString = String(username)
    return usernameString
}
