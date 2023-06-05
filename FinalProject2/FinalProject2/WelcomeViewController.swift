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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        vectorImage.image = UIImage(named: "vector4")
        firstImage.image = UIImage(named: "image7")
        secondImage.image = UIImage(named: "image8")
        
        view.addSubview(vectorImage)
        view.addSubview(firstImage)
        view.addSubview(secondImage)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            vectorImage.topAnchor.constraint(equalTo: view.topAnchor),
            
            firstImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            firstImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            secondImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            secondImage.bottomAnchor.constraint(equalTo: firstImage.bottomAnchor, constant: -50),
            
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            label.heightAnchor.constraint(equalToConstant: 68)
        ])
    }
}
