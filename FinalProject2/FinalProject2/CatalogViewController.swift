//
//  CatalogViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit

extension CatalogViewController: productViewDelegate {
    func update() {
        delegate?.updateBadgeValue(value: orders.count == 0 ? nil : "\(orders.count)", color: .gray)
    }
}

class CatalogViewController: UIViewController, UIScrollViewDelegate {
    weak var delegate: CartViewControllerDelegate?
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
        APIManager.shared.getPost(collection: "sneakers", docName: "sneakers1") { doc in
            guard doc == nil else { return }
            sneakers.append(Sneakers(imageName: <#T##String#>, name: <#T##String#>, description: <#T##String#>, price: <#T##Int#>))
        }
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for stackView in stackViews {
            for view in stackView.arrangedSubviews {
                view.removeFromSuperview()
                stackView.removeArrangedSubview(view)
            }
        }
        
        for i in 0..<sneakers.count/2 {
            let product1 = productView(sneakers: sneakers[i * 2])
            let product2 = productView(sneakers: sneakers[i * 2 + 1])
            product1.delegate = self
            product2.delegate = self
            stackViews[i].addArrangedSubview(product1)
            stackViews[i].addArrangedSubview(product2)
        }
    }
    
    func setup() {
        self.navigationItem.title = "Hello, Sneakerhead!"
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
            scrolView.topAnchor.constraint(equalTo: view.topAnchor, constant: h * CGFloat(98/844.0)),
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

//MARK: SNEAKERS
struct Sneakers: Hashable {
    var imageName: String
    var name: String
    var description: String
    var price: Int
}

//MARK: PRODUCT VIEW
class productView: UIView {
    weak var delegate: productViewDelegate?
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
        button.layer.cornerRadius = 20
        return button
    }()
    
    var sneakers: Sneakers
    
    init(sneakers: Sneakers) {
        self.sneakers = sneakers
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.layer.cornerRadius = 4
        imageView.image = UIImage(named: sneakers.imageName)
        nameLabel.text = sneakers.name
        descriptionLabel.text = sneakers.description
        priceLabel.text = "$\(sneakers.price)"
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        setUpPricelabel()
        setupAddButton()
        setup()
    }
    
    func setupAddButton() {
        if let numberOfOrders = orders[sneakers] {
            if numberOfOrders == 0 {
                addButton.setTitle("Add to cart", for: .normal)
                addButton.backgroundColor = .black
            }
            else {
                addButton.setTitle("Remove", for: .normal)
                addButton.backgroundColor = .gray
            }
        } else {
            addButton.setTitle("Add to cart", for: .normal)
            addButton.backgroundColor = .black
        }
    }
    
    func setUpPricelabel() {
        if let numberOfOrders = orders[sneakers] {
            if numberOfOrders != 0 {
                priceLabel.text = "\(numberOfOrders) · \(self.sneakers.price)"
            }
            else {
                priceLabel.text = "$\(self.sneakers.price)"
            }
        }
        else {
            priceLabel.text = "$\(self.sneakers.price)"
        }
    }
    
    func setup() {
        self.backgroundColor = .white
        [imageView, nameLabel, descriptionLabel, priceLabel, addButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 282),
            self.widthAnchor.constraint(equalToConstant: w * CGFloat(174/390.0)),
            
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

extension productView {
    @objc func addButtonTapped(_ sender: UIButton) {
        if addButton.titleLabel?.text == "Add to cart" {
            orders[sneakers] = 1
            delegate?.update()
        }
        else {
            if let numberOfOrders = orders[sneakers] {
                if numberOfOrders == 1 {
                    orders[sneakers] = nil
                    delegate?.update()
                }
                else {
                    orders[sneakers] = numberOfOrders - 1
                }
            }
        }
        setupAddButton()
        setUpPricelabel()
    }
}

protocol productViewDelegate: AnyObject {
    func update()
}
