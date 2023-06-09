//
//  TestViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 05.06.2023.
//

import UIKit

let h = UIScreen.main.bounds.height
let w = UIScreen.main.bounds.width

class OnboardingViewController: UIViewController {
    
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
        setup()
    }
    
    func setup() {
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
            secondImage.topAnchor.constraint(equalTo: view.topAnchor, constant: h * CGFloat(90/844.0)),
            secondImage.heightAnchor.constraint(equalToConstant: h * CGFloat(192/844.0)),
            secondImage.widthAnchor.constraint(equalToConstant: w * CGFloat(231/390.0)),
            
            firstImage.heightAnchor.constraint(equalToConstant: h * CGFloat(495/844.0)),
            firstImage.widthAnchor.constraint(equalToConstant: w * CGFloat(346/390.0)),
            firstImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            firstImage.bottomAnchor.constraint(equalTo: secondImage.bottomAnchor, constant: h * CGFloat(220/844.0)),
            
            vectorImage.heightAnchor.constraint(equalToConstant: h * CGFloat(396/844.0)),
            vectorImage.widthAnchor.constraint(equalToConstant: w),
            vectorImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -h * CGFloat(10/844.0)),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
