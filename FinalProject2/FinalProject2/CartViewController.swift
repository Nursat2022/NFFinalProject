//
//  CartViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit

class CartViewController: UIViewController {
    let scrollView = UIScrollView()
    private let contentView = UIView()
    let totalView = UIView()
    
    lazy var totalLabel: UILabel = {
        let label = UILabel()
        //MARK: CHANGE
        label.text = "4 items: Total (Including Delivery)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        //MARK: CHANGE
        label.text = "$1232"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    lazy var confirmButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm Order", for: .normal)
        return button
    }()
    
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
        self.title = "Cart"
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        totalView.addSubview(totalLabel)
        totalView.addSubview(priceLabel)
        
//        VStackView.addArrangedSubview(CartView(sneakers: sneakers[0]))
//        VStackView.addArrangedSubview(CartView(sneakers: sneakers[1]))
        for order in orders {
//            VStackView.addArrangedSubview(CartView(sneakers: order.))
        }
        VStackView.addArrangedSubview(totalView)
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = view.backgroundColor
        totalView.translatesAutoresizingMaskIntoConstraints = false
        totalView.backgroundColor = .white
        
        for myView in VStackView.arrangedSubviews {
            myView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        VStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        view.addSubview(confirmButton)
        scrollView.addSubview(contentView)
        contentView.addSubview(VStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            VStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            VStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            totalView.heightAnchor.constraint(equalToConstant: 50),
            totalView.leftAnchor.constraint(equalTo: VStackView.leftAnchor),
            totalView.rightAnchor.constraint(equalTo: VStackView.rightAnchor),
            
            totalLabel.centerYAnchor.constraint(equalTo: totalView.centerYAnchor),
            totalLabel.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 16),
            
            priceLabel.centerYAnchor.constraint(equalTo: totalView.centerYAnchor),
            priceLabel.rightAnchor.constraint(equalTo: totalView.rightAnchor,constant: -16),
            
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            confirmButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
            confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 54),
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
        label.numberOfLines = 0
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
        //MARK: CHANGE
        button.setTitle("3", for: .normal)
        button.layer.cornerRadius = 17
        return button
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return button
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
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
        [imageView, nameLabel, descriptionLabel, priceLabel, addButton, minusButton, plusButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        self.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 160),
            self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 140),
            imageView.widthAnchor.constraint(equalToConstant: 140),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 21),
            nameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            descriptionLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),

            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            priceLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            priceLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),

            addButton.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            addButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -52),
            addButton.heightAnchor.constraint(equalToConstant: 36),
            addButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            
            minusButton.leftAnchor.constraint(equalTo: addButton.leftAnchor, constant: 15),
            minusButton.rightAnchor.constraint(equalTo: addButton.centerXAnchor, constant: -15),
            minusButton.topAnchor.constraint(equalTo: addButton.topAnchor),
            minusButton.heightAnchor.constraint(equalToConstant: 36),
            
            plusButton.leftAnchor.constraint(equalTo: addButton.centerXAnchor, constant: 15),
            plusButton.rightAnchor.constraint(equalTo: addButton.rightAnchor, constant: -15),
            plusButton.topAnchor.constraint(equalTo: addButton.topAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

