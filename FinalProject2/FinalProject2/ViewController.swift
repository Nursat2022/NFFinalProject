//
//  ViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 05.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var roundedRectangle: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let firstImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var vectorImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
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
        
        [firstImage, containerView, secondImage].forEach {
            view.addSubview($0)
        }
        
        containerView.addSubview(roundedRectangle)
        containerView.addSubview(vectorImage)
        containerView.bringSubviewToFront(roundedRectangle)
        
        firstImage.image = UIImage(named: "image1")
        vectorImage.image = UIImage(named: "vector1")
        secondImage.image = UIImage(named: "image2")
        roundedRectangle.image = UIImage(named: "RoundedRect1")
        NSLayoutConstraint.activate([
            roundedRectangle.leftAnchor.constraint(equalTo: view.leftAnchor),
            roundedRectangle.rightAnchor.constraint(equalTo: view.rightAnchor),
            roundedRectangle.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            roundedRectangle.heightAnchor.constraint(equalToConstant: 288),
            
            secondImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            secondImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            
            vectorImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}

