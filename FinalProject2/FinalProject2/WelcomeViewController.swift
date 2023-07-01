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
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Welcome to the biggest sneakers store app"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .center
        return stackView
    }()
    
    let SignUpButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Sign up", for: .normal)
        return button
    }()

    let firstImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let secondImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let SignInButton: UIButton = {
        let button = UIButton()
        button.setTitle("I already have an account", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        vectorImage.image = UIImage(named: "vector5")
        firstImage.image = UIImage(named: "welcomePageSneakers1")
        secondImage.image = UIImage(named: "welcomePageSneakers2")
        
        SignUpButton.addTarget(self, action: #selector(signUp(_:)), for: .touchUpInside)
        SignInButton.addTarget(self, action: #selector(signIn(_:)), for: .touchUpInside)
        
        [vectorImage, label, stackView, firstImage, secondImage, SignInButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(SignUpButton)
        stackView.addArrangedSubview(SignInButton)
        
        [vectorImage, firstImage, secondImage, stackView].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            vectorImage.topAnchor.constraint(equalTo: view.topAnchor),
            vectorImage.heightAnchor.constraint(equalToConstant: h * CGFloat(349/844.0)),
            vectorImage.widthAnchor.constraint(equalToConstant: w),
            
            firstImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            firstImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: h * CGFloat(20/844.0)),
            firstImage.heightAnchor.constraint(equalToConstant: h * CGFloat(228/844.0)),
            firstImage.widthAnchor.constraint(equalToConstant: h * CGFloat(206/844.0)),
            
            secondImage.heightAnchor.constraint(equalToConstant: h * CGFloat(246/844.0)),
            secondImage.widthAnchor.constraint(equalToConstant: h * CGFloat(195/844.0)),
            secondImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            secondImage.bottomAnchor.constraint(equalTo: firstImage.bottomAnchor, constant: -h * CGFloat(50/844.0)),

            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -h * CGFloat(70/844.0)),
            
            SignUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            SignUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            SignUpButton.heightAnchor.constraint(equalToConstant: 54),
            
            SignInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36),
            SignInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -36),
        ])
    }
}

extension WelcomeViewController {
    // again no need in my opinion for extracting actions to extension of class
    @objc func signUp(_ sender: UIButton) {
        let registrationViewController = RegistrationViewController()
        self.navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    @objc func signIn(_ sender: UIButton) {
        let authViewController = AuthViewController()
        self.navigationController?.pushViewController(authViewController, animated: true)
    }
}
