//
//  TestViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 05.06.2023.
//

import UIKit

class TestViewController: UIViewController {
    
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
    
    init(firstImageName: String, secondImageName: String, vectorImageName: String) {
        super.init(nibName: nil, bundle: nil)
        firstImage.image = UIImage(named: firstImageName)
        secondImage.image = UIImage(named: secondImageName)
        vectorImage.image = UIImage(named: vectorImageName)
//        roundedRectangle.image = UIImage(named: "RoundedRect1")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        [firstImage, containerView, secondImage].forEach {
            view.addSubview($0)
        }
        
        containerView.addSubview(vectorImage)
        containerView.bringSubviewToFront(roundedRectangle)
        
        NSLayoutConstraint.activate([
//            roundedRectangle.leftAnchor.constraint(equalTo: view.leftAnchor),
//            roundedRectangle.rightAnchor.constraint(equalTo: view.rightAnchor),
//            roundedRectangle.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            roundedRectangle.heightAnchor.constraint(equalToConstant: 288),
            
            secondImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            secondImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            
            vectorImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
