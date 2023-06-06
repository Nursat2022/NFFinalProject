//
//  CatalogViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit

class CatalogViewController: UIViewController, UIScrollViewDelegate {
    let sneakers = [Sneakers(imageName: "sneakers1", name: "Dolce & Gabbana", description: "Кеды с принтом граффити", price: 1251), Sneakers(imageName: "sneakers2", name: "Off-White", description: "Кроссовки Off-Court 3.0", price: 551), Sneakers(imageName: "sneakers3", name: "Jordan", description: "Кеды с принтом граффити", price: 1251), Sneakers(imageName: "sneakers4", name: "Jordan", description: "Кеды с принтом граффити", price: 1251), Sneakers(imageName: "sneakers5", name: "Balenciaga", description: "кроссовки Runner", price: 945), Sneakers(imageName: "sneakers6", name: "Lanvin", description: "кроссовки Curb на шнуровке", price: 700), Sneakers(imageName: "sneakers7", name: "Off-White", description: "кроссовки Odsy-1000", price: 900), Sneakers(imageName: "sneakers8", name: "Adidas YEEZY", description: "Кроссовки YEEZY 700 V3 Copper Fade", price: 255), Sneakers(imageName: "sneakers9", name: "Jordan", description: "кроссовки Jordan Max Aura 4", price: 543), Sneakers(imageName: "sneakers10", name: "Jordan", description: "кроссовки Air Jordan 1 Retro", price: 350), Sneakers(imageName: "sneakers11", name: "Off-White", description: "кроссовки с логотипом Arrows", price: 405), Sneakers(imageName: "sneakers12", name: "Maison Mihara Yasuhiro", description: "кроссовки с контрастной шнуровкой", price: 700)]
    
    let scrolView = UIScrollView()
    private let contentView = UIView()
    
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
        
        scrolView.showsVerticalScrollIndicator = true
        scrolView.translatesAutoresizingMaskIntoConstraints = false
        scrolView.alwaysBounceVertical = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = view.backgroundColor

        for i in 0..<sneakers.count/2 {
            stackViews[i].addArrangedSubview(productView(sneakers: sneakers[i * 2]))
            stackViews[i].addArrangedSubview(productView(sneakers: sneakers[i * 2 + 1]))
        }
        
        stackViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            VStackView.addArrangedSubview($0)
        }
        
        VStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrolView)
        scrolView.addSubview(contentView)
        contentView.addSubview(VStackView)
        
        
        NSLayoutConstraint.activate([
            scrolView.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
            scrolView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            scrolView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            scrolView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrolView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrolView.rightAnchor),
            contentView.leftAnchor.constraint(equalTo: scrolView.leftAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrolView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrolView.widthAnchor),
            
            VStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            VStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
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
        label.numberOfLines = 0
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
