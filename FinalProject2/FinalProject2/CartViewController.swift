//
//  CartViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit

var today = Date()

class CartViewController: UIViewController {
    weak var delegate: CartViewControllerDelegate?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        update()
    }
    
    let vectorImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "vector5")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Cart is empty"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emptySubLabel: UILabel = {
        let label = UILabel()
        label.text = "Find interesting models in the Catalog."
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scrollView = UIScrollView()
    private let contentView = UIView()
    let totalView = UIView()
    
    lazy var productCount: Int = {
        var ordersValue = orders.values
        var orders = ordersValue.reduce(0, +)
        return orders
    }()
    
    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "\(productCount) items: Total (Including Delivery)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var totalPrice: Int = {
        var totalPrice = 0
        for (key, value) in orders {
            totalPrice += key.price * value
        }
        return totalPrice
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$\(totalPrice)"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    lazy var confirmButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm Order", for: .normal)
        button.addTarget(self, action: #selector(confirm(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.updateBadgeValue(value: orders.count == 0 ? nil : "\(orders.count)", color: .gray)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        delegate?.updateBadgeValue(value: orders.count == 0 ? nil : "\(orders.count)", color: .black)
        productCount = orders.values.reduce(0, +)
        
        var count = 0
        for (key, value) in orders {
            count += key.price * value
        }
        totalPrice = count
        
        totalLabel.text = "\(productCount) items: Total (Including Delivery)"
        priceLabel.text = "$\(totalPrice)"
        if productCount == 0 {
            emptyVStackView.isHidden = false
            vectorImage.isHidden = false
            
            VStackView.isHidden = true
            totalView.isHidden = true
            confirmButton.isHidden = true
        }
        else {
            confirmButton.isHidden = false
            VStackView.isHidden = false
            totalView.isHidden = false
            emptyVStackView.isHidden = true
            vectorImage.isHidden = true
        }
    }
    
    lazy var VStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var emptyVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func update() {
        for myView in VStackView.arrangedSubviews {
            if let view = myView as? CartView {
                view.removeFromSuperview()
                VStackView.removeArrangedSubview(view)
            }
        }
        
        for order in orders {
            let cartView = CartView(sneakers: order.key)
            cartView.delegate = self
            VStackView.addArrangedSubview(cartView)
        }
        VStackView.addArrangedSubview(totalView)
    }
    
    func setup() {
        for order in orders {
            let cartView = CartView(sneakers: order.key)
            cartView.delegate = self
            VStackView.addArrangedSubview(cartView)
        }
        
        self.navigationItem.title = "Cart"
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        totalView.addSubview(totalLabel)
        totalView.addSubview(priceLabel)
        
        if productCount == 0 {
            emptyVStackView.isHidden = false
            vectorImage.isHidden = false
            
            VStackView.isHidden = true
            totalView.isHidden = true
            confirmButton.isHidden = true
        }
        else {
            emptyVStackView.isHidden = true
            vectorImage.isHidden = true
        }
        emptyVStackView.addArrangedSubview(emptyLabel)
        emptyVStackView.addArrangedSubview(emptySubLabel)
        
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
        view.addSubview(vectorImage)
        view.addSubview(emptyVStackView)
        scrollView.addSubview(contentView)
        contentView.addSubview(VStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: h * CGFloat(98/844.0)),
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
            
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -h * CGFloat(100/844.0)),
            confirmButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
            confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 54),
            
            vectorImage.topAnchor.constraint(equalTo: view.topAnchor),
            vectorImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            vectorImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/2 - 30),
            
            emptyVStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyVStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

extension CartViewController {
    func updateUI() {
        if productCount == 0 {
            emptyVStackView.isHidden = false
            vectorImage.isHidden = false
            
            VStackView.isHidden = true
            totalView.isHidden = true
            confirmButton.isHidden = true
        }
        else {
            confirmButton.isHidden = false
            VStackView.isHidden = false
            totalView.isHidden = false
            emptyVStackView.isHidden = true
            vectorImage.isHidden = true
        }
    }
}

//MARK: VC
extension CartViewController {
    @objc func confirm(_ sender: UIButton) {
        let vc = BottomSheetViewController()
        vc.button.addAction(.init(handler: { [self] _ in
            vc.dismiss(animated: true)
            updateUI()
            numberOfOrders += 1
        }), for: .touchUpInside)
        
        vc.isModalInPresentation = true
        
        let navVC = UINavigationController(rootViewController: vc)
        
        if let sheet = navVC.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        navigationController?.present(navVC, animated: true, completion: { [self] in
            orderHistory.append(orderData(number: numberOfOrders, date: "\(today.getDay())", numberOfItems: productCount, totalPrice: totalPrice, products: orders))
            orders = [:]
            delegate?.updateBadgeValue(value: orders.count == 0 ? nil : "\(orders.count)", color: .black)
            productCount = 0
        })
    }
}

class CartView: UIView {
    weak var delegate: CartViewDelegate?
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
        button.layer.cornerRadius = 17
        return button
    }()
    
    let sneakers: Sneakers
    
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
        self.sneakers = sneakers
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        imageView.image = UIImage(named: sneakers.imageName)
        nameLabel.text = sneakers.name
        descriptionLabel.text = sneakers.description
        priceLabel.text = "$\(sneakers.price)"
        self.layer.cornerRadius = 4
        setupAddButton()
        setup()
    }
    
    func setupAddButton() {
        addButton.setTitle("\(orders[sneakers]!)", for: .normal)
    }
    
    func setup() {
        
        minusButton.addTarget(self, action: #selector(minusTapped(_:)), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusTapped(_:)), for: .touchUpInside)
        
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

//MARK: EXTENSION CartView
extension CartView {
    @objc func minusTapped(_ sender: UIButton) {
        orders[sneakers]! -= 1
        if orders[self.sneakers]! == 0 {
            orders[self.sneakers] = nil
            self.removeFromSuperview()
        }
        else {
            setupAddButton()
        }
        delegate?.cartViewDidUpdateProductCount(self, count: -1)
    }
    
    @objc func plusTapped(_ sender: UIButton) {
        orders[sneakers]! += 1
        setupAddButton()
        delegate?.cartViewDidUpdateProductCount(self, count: 1)
    }
}

//MARK: PROTOCOLS
protocol CartViewDelegate: AnyObject {
    func cartViewDidUpdateProductCount(_ cartView: CartView, count: Int)
}

protocol CartViewControllerDelegate: AnyObject {
    func updateBadgeValue(value: String?, color: UIColor?)
}

//MARK: EXTENSION CartViewController
extension CartViewController: CartViewDelegate {
    func cartViewDidUpdateProductCount(_ cartView: CartView, count: Int) {
        productCount += count
        totalLabel.text = "\(productCount) items: Total (Including Delivery)"
        
        totalPrice += count * cartView.sneakers.price
        priceLabel.text = "$\(totalPrice)"
        
        if productCount == 0 {
            updateUI()
        }
        delegate?.updateBadgeValue(value: orders.count == 0 ? nil : "\(orders.count)", color: .black)
    }
}
