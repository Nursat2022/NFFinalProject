//
//  CatalogViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

extension CatalogViewController: productViewDelegate {
    func update() {
        print("updating")
        delegate?.updateBadgeValue(value: orders.count == 0 ? nil : "\(orders.count)", color: .gray)
    }
}

class CatalogViewController: UIViewController, UIScrollViewDelegate {
    weak var delegate: CartViewControllerDelegate?
    let scrolView = UIScrollView()
    private let contentView = UIView()
    
    lazy var VStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loader = loader(viewController: self)
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        self.getSneakers(num: 1) { newSneakers in
            sneakers = newSneakers
            self.getOrders {
                stopLoader(loader: loader)
                self.update()
                self.setup()
                print(orders.count)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for stackView in stackViews {
            for view in stackView.arrangedSubviews {
                view.removeFromSuperview()
                stackView.removeArrangedSubview(view)
            }
        }
        
        if !stackViews.isEmpty {
            for i in 0..<sneakers.count/2 {
                let product1 = productView(sneakers: sneakers[i * 2])
                let product2 = productView(sneakers: sneakers[i * 2 + 1])
                product1.delegate = self
                product2.delegate = self
                stackViews[i].addArrangedSubview(product1)
                stackViews[i].addArrangedSubview(product2)
            }
        }
    }
    
    var stackViews = [UIStackView]()
    
    func setup() {
//        APIManager.shared.writeData(sneakersName: "sneakers5", count: 5)
        setupStackViews()
        self.navigationItem.title = "Hello, Sneakerhead!"
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        scrolView.showsVerticalScrollIndicator = true
        scrolView.translatesAutoresizingMaskIntoConstraints = false
        scrolView.alwaysBounceVertical = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = view.backgroundColor
        
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

extension CatalogViewController {
    func setupStackViews() {
        for i in 0..<sneakers.count/2 + 1 {
            stackViews.append(UIStackView())
        }
        stackViews.forEach {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.alignment = .center
        }
        
        for i in 0..<sneakers.count/2 {
            stackViews[i].addArrangedSubview(productView(sneakers: sneakers[i * 2]))
            stackViews[i].addArrangedSubview(productView(sneakers: sneakers[i * 2 + 1]))
        }
    }
}

//MARK: SNEAKERS
struct Sneakers: Hashable {
    var image: UIImage
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
        imageView.image = sneakers.image
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
            APIManager.shared.writeData(sneakersName: getNameBySneakers(sneakers), count: orders[sneakers]!)
            delegate?.update()
        }
        else {
            if let numberOfOrders = orders[sneakers] {
                if numberOfOrders == 1 {
                    orders[sneakers] = nil
                    delegate?.update()
                    APIManager.shared.deleteData(document: getNameBySneakers(sneakers))
                }
                else {
                    orders[sneakers] = numberOfOrders - 1
                    APIManager.shared.writeData(sneakersName: getNameBySneakers(sneakers), count: orders[sneakers]!)
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

extension CatalogViewController {
    func getSneakers(num: Int, completion: @escaping ([Sneakers]) -> Void) {
        var newSneakers = [Sneakers]()
        APIManager.shared.getAllPosts(collection: "sneakers") { documents in
            guard documents != nil else {
                print("documents error")
                return }
            for doc in documents! {
                APIManager.shared.getImageByName(imageName: doc.imageName) { image in
                    guard image != nil else { return }
                    let sneakers = Sneakers(image: image!, name: doc.name, description: doc.description, price: doc.price)
                    sneakersByImageName[doc.imageName] = sneakers
                    newSneakers.append(sneakers)
                    if newSneakers.count == documents?.count {
                        completion(newSneakers)
                    }
                }
            }
        }
    }
    
    func getOrders(completion: @escaping () -> Void) {
        if let user = Auth.auth().currentUser {
            print(user.email)
        }
        APIManager.shared.getAllOrders(collection: Auth.auth().currentUser!.email!) { order in
            for key in order.keys {
                orders[sneakersByImageName[key]!] = order[key]
            }
            completion()
        }
    }
}

