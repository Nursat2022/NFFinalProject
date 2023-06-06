//
//  TestViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 05.06.2023.
//

import UIKit

class TestViewController: UIViewController {
    
    let roundedRectangle: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let firstImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let vectorImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let secondImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    init(firstImageName: String, secondImageName: String, vectorImageName: String) {
        super.init(nibName: nil, bundle: nil)
        firstImage.image = UIImage(named: firstImageName)
        secondImage.image = UIImage(named: secondImageName)
        vectorImage.image = UIImage(named: vectorImageName)
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
        
        [vectorImage, roundedRectangle].forEach {
            containerView.addSubview($0)
        }
        
        [roundedRectangle, firstImage, vectorImage, secondImage, containerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            secondImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            secondImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            
            vectorImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
