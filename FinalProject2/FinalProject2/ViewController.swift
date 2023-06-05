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
        view.image = UIImage(named: "RoundedRect3")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let firstImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var secondImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let yellowImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [firstImage, containerView, yellowImage].forEach {
            view.addSubview($0)
        }
        
        containerView.addSubview(roundedRectangle)
        containerView.addSubview(secondImage)
        containerView.bringSubviewToFront(roundedRectangle)
        
        firstImage.image = UIImage(named: "image5")
        secondImage.image = UIImage(named: "vector3")
        yellowImage.image = UIImage(named: "image6")
        NSLayoutConstraint.activate([
            roundedRectangle.leftAnchor.constraint(equalTo: view.leftAnchor),
            roundedRectangle.rightAnchor.constraint(equalTo: view.rightAnchor),
            roundedRectangle.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            roundedRectangle.heightAnchor.constraint(equalToConstant: 288),
            
            yellowImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            yellowImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            
            secondImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}

