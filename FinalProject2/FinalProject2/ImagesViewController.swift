//
//  ImagesViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 08.06.2023.
//

import UIKit

class ImagesViewController: UIViewController {

    let images = threeImages()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(images)
        images.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            images.heightAnchor.constraint(equalToConstant: 100),
            images.widthAnchor.constraint(equalToConstant: 120),
            images.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            images.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

class threeImages: UIView {
    let image1: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "ellipse1")
        return view
    }()
    
    let image2: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "ellipse1")
        return view
    }()
    
    let image3: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "ellipse1")
        return view
    }()
    
    lazy var HStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = -16
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        HStackView.addArrangedSubview(image1)
        HStackView.addArrangedSubview(image2)
        HStackView.addArrangedSubview(image3)
        
        self.backgroundColor = .lightGray
        
        self.addSubview(HStackView)
        
        NSLayoutConstraint.activate([
            image1.heightAnchor.constraint(equalToConstant: 44),
            image1.widthAnchor.constraint(equalToConstant: 44),
            
            image2.heightAnchor.constraint(equalToConstant: 44),
            image2.widthAnchor.constraint(equalToConstant: 44),
            
            image3.heightAnchor.constraint(equalToConstant: 44),
            image3.widthAnchor.constraint(equalToConstant: 44),
            
            HStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            HStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
