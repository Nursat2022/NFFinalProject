//
//  CartViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit

class CartViewController: UIViewController {

    let sneakers = [Sneakers(imageName: "sneakers1", name: "Dolce & Gabbana", description: "Кеды с принтом граффити", price: 1251), Sneakers(imageName: "sneakers2", name: "Off-White", description: "Кроссовки Off-Court 3.0", price: 551), Sneakers(imageName: "sneakers3", name: "Jordan", description: "Кеды с принтом граффити", price: 1251), Sneakers(imageName: "sneakers4", name: "Jordan", description: "Кеды с принтом граффити", price: 1251), Sneakers(imageName: "sneakers1", name: "Dolce & Gabbana", description: "Кеды с принтом граффити", price: 1251), Sneakers(imageName: "sneakers2", name: "Off-White", description: "Кроссовки Off-Court 3.0", price: 1251)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    lazy var VStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    func setup() {
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        VStackView.addArrangedSubview(CartView(sneakers: sneakers[0]))
        VStackView.addArrangedSubview(CartView(sneakers: sneakers[1]))
        VStackView.backgroundColor = .red
        for myView in VStackView.arrangedSubviews {
            myView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        VStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(VStackView)
        
        NSLayoutConstraint.activate([
            VStackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            VStackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            VStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 104),
        ])
    }
}

class CartView: UIView {
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
    let addButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Add to cart", for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
    init(sneakers: Sneakers) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        imageView.image = UIImage(named: sneakers.imageName)
        nameLabel.text = sneakers.name
        descriptionLabel.text = sneakers.description
        priceLabel.text = "$\(sneakers.price)"
        self.layer.cornerRadius = 4
        setup()
    }
    
    func setup() {
        self.backgroundColor = .white
        [imageView, nameLabel, descriptionLabel, priceLabel, addButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 282),
            self.widthAnchor.constraint(equalToConstant: 174),
            
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),
            imageView.heightAnchor.constraint(equalToConstant: 166),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2),
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
            nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
            descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),

            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 2),
            priceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
            priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),

            addButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
            addButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),
            addButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

