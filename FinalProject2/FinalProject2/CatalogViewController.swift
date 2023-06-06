//
//  CatalogViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit

class CatalogViewController: UIViewController, UIScrollViewDelegate {
    let sneakers = [Sneakers(imageName: "sneakers1", name: "Dolce & Gabbana", description: "Кеды с принтом граффити", price: 1251), Sneakers(imageName: "sneakers2", name: "Off-White", description: "Кроссовки Off-Court 3.0", price: 551), Sneakers(imageName: "sneakers3", name: "Jordan", description: "Кеды с принтом граффити", price: 1251), Sneakers(imageName: "sneakers4", name: "Jordan", description: "Кеды с принтом граффити", price: 1251), Sneakers(imageName: "sneakers1", name: "Dolce & Gabbana", description: "Кеды с принтом граффити", price: 1251), Sneakers(imageName: "sneakers2", name: "Off-White", description: "Кроссовки Off-Court 3.0", price: 1251)]
    
    let scrolView = UIScrollView()
    
    lazy var stackViews: [UIStackView] = {
        var stackViews = [UIStackView]()
        for i in 0..<sneakers.count/2 {
            stackViews.append(UIStackView())
        }
        stackViews.forEach {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.alignment = .center
        }
        return stackViews
    }()
    
    lazy var VStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.title = "Hello, Sneakerhead!"
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)

//        stackViews[0].addArrangedSubview(productView(sneakers: sneakers[0]))
//        stackViews[0].addArrangedSubview(productView(sneakers: sneakers[1]))
//
//        stackViews[1].addArrangedSubview(productView(sneakers: sneakers[2]))
//        stackViews[1].addArrangedSubview(productView(sneakers: sneakers[3]))
//
//        stackViews[2].addArrangedSubview(productView(sneakers: sneakers[2]))
//        stackViews[2].addArrangedSubview(productView(sneakers: sneakers[3]))
        
        for i in 0..<sneakers.count/2 {
            stackViews[i].addArrangedSubview(productView(sneakers: sneakers[i * 2]))
            stackViews[i].addArrangedSubview(productView(sneakers: sneakers[i * 2 + 1]))
        }
        
//        for sneaker in stackViews[0].arrangedSubviews {
//            sneaker.translatesAutoresizingMaskIntoConstraints = false
//        }
//
//        for sneaker in stackViews[1].arrangedSubviews {
//            sneaker.translatesAutoresizingMaskIntoConstraints = false
//        }
//
//        for sneaker in stackViews[2].arrangedSubviews {
//            sneaker.translatesAutoresizingMaskIntoConstraints = false
//        }
        
        stackViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            VStackView.addArrangedSubview($0)
        }
        
//        VStackView.addArrangedSubview(stackViews[0])
//        VStackView.addArrangedSubview(stackViews[1])
        
//        view.addSubview(stackViews[0])
//        view.addSubview(stackViews[1])
//        scrolView.addSubview(stackViews[0])
//        scrolView.addSubview(stackViews[1])
//        scrolView.addSubview(stackViews[2])
        scrolView.delegate = self
        scrolView.addSubview(VStackView)
        scrolView.showsVerticalScrollIndicator = true
        scrolView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(scrolView)
        VStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrolView)
        
        NSLayoutConstraint.activate([
            
//            stackViews[0].leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
//            stackViews[0].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
//            stackViews[0].topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
//
//            stackViews[1].leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
//            stackViews[1].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
//            stackViews[1].topAnchor.constraint(equalTo: stackViews[0].bottomAnchor, constant: 10),
            
//            stackViews[2].leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
//            stackViews[2].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
//            stackViews[2].topAnchor.constraint(equalTo: stackViews[0].bottomAnchor, constant: 10),
            
            
            
            scrolView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            scrolView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            scrolView.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
            scrolView.heightAnchor.constraint(equalToConstant: 1000)
//            VStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
//            VStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
//            VStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
        ])
    }
}

struct Sneakers {
    var imageName: String
    var name: String
    var description: String
    var price: Int
}

class productView: UIView {
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
