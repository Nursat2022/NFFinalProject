//
//  AuthViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {
    
    let stateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 15)
        label.isHidden = true
        return label
    }()
    
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
        view.addSubview(stateLabel)
        
        [usernameField, passwordField, stackView, signInButton, stateLabel].forEach {
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
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -h * CGFloat(50/844.0)),
            
            stateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension AuthViewController {
    @objc func signIn(_ sender: UIButton) {
        print("tapped")
        let loader = loader(viewController: self)
        stateLabel.isHidden = false
        guard let email = usernameField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            stopLoader(loader: loader)
            stateLabel.text = "missing field data"
            return
        }

        FirebaseAuth.Auth.auth().signIn(withEmail: email + "@gmail.com", password: password) { [weak self] result, error in
            guard let strongSelf = self else {return}
            
            guard error == nil else {
                stopLoader(loader: loader)
                strongSelf.stateLabel.text = "Wrong username or password"
                return
            }
//            UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.3, options: .transitionCrossDissolve, animations: {
//                let oldState = UIView.areAnimationsEnabled
//                UIView.setAnimationsEnabled(false)
//                UIApplication.shared.keyWindow?.rootViewController = TabBarController()
//                UIView.setAnimationsEnabled(oldState)
//            }, completion: nil)
            let transition = CATransition()
            transition.duration = 0.1
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            
            stopLoader(loader: loader)
            UIApplication.shared.keyWindow?.layer.add(transition, forKey: nil)
            UIApplication.shared.keyWindow?.rootViewController = TabBarController()
        }
    }
}

//MARK: LOADER

func loader(viewController: UIViewController) -> UIAlertController {
    let alert = UIAlertController(title: nil, message: "Please wait", preferredStyle: .alert)
    let indicator = UIActivityIndicatorView(frame: CGRect(x: 15, y: 15, width: 30, height: 30))
    indicator.hidesWhenStopped = true
    indicator.startAnimating()
    indicator.style = .medium
    alert.view.addSubview(indicator)
    viewController.present(alert, animated: true)
    return alert
}

func stopLoader(loader: UIAlertController) {
    DispatchQueue.main.async {
        loader.dismiss(animated: true)
    }
}
