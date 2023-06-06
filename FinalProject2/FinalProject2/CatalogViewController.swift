//
//  CatalogViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit

class CatalogViewController: UIViewController {
    let sneakers = [Sneakers(imageName: "sneakers1", name: "Dolce & Gabbana", description: "Кеды с принтом граффити", price: 1251), Sneakers(imageName: "sneakers2", name: "Dolce & Gabbana", description: "Кеды с принтом граффити", price: 1251)]
    
    let addButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Add to cart", for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
    let sneakersView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.title = "Hello, Sneakerhead!"
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        imageView.image = UIImage(named: sneakers[0].imageName)
        nameLabel.text = sneakers[0].name
        descriptionLabel.text = sneakers[0].description
        priceLabel.text = "$\(sneakers[0].price)"
        sneakersView.addSubview(imageView)
        sneakersView.addSubview(nameLabel)
        sneakersView.addSubview(descriptionLabel)
        sneakersView.addSubview(priceLabel)
        sneakersView.addSubview(addButton)
        view.addSubview(sneakersView)
        
        [sneakersView, imageView, nameLabel, descriptionLabel, priceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            sneakersView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sneakersView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            sneakersView.heightAnchor.constraint(equalToConstant: 282),
            sneakersView.widthAnchor.constraint(equalToConstant: 174),
            
            imageView.topAnchor.constraint(equalTo: sneakersView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: sneakersView.leftAnchor, constant: 4),
            imageView.rightAnchor.constraint(equalTo: sneakersView.rightAnchor, constant: -4),
            imageView.heightAnchor.constraint(equalToConstant: 166),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2),
            nameLabel.leftAnchor.constraint(equalTo: sneakersView.leftAnchor, constant: 4),
            nameLabel.rightAnchor.constraint(equalTo: sneakersView.rightAnchor, constant: -4),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            descriptionLabel.leftAnchor.constraint(equalTo: sneakersView.leftAnchor, constant: 4),
            descriptionLabel.rightAnchor.constraint(equalTo: sneakersView.rightAnchor, constant: -4),
            
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 2),
            priceLabel.leftAnchor.constraint(equalTo: sneakersView.leftAnchor, constant: 4),
            priceLabel.rightAnchor.constraint(equalTo: sneakersView.rightAnchor, constant: -4),
            
            addButton.leftAnchor.constraint(equalTo: sneakersView.leftAnchor, constant: 4),
            addButton.rightAnchor.constraint(equalTo: sneakersView.rightAnchor, constant: -4),
            addButton.bottomAnchor.constraint(equalTo: sneakersView.bottomAnchor, constant: -8),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

struct Sneakers {
    var imageName: String
    var name: String
    var description: String
    var price: Int
}
