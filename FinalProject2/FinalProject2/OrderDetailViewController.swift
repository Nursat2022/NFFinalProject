//
//  OrderDetailViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 08.06.2023.
//

import UIKit

//let orderDetail = []

class OrderDetailViewController: UIViewController {
    
    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.barTintColor = .black
        self.title = "Order #123"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellForData.self, forCellReuseIdentifier: "cell")
        tableView.register(cellForProduct.self, forCellReuseIdentifier: "productCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = view.backgroundColor
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 104),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cellForData
            cell.isUserInteractionEnabled = false
            cell.namelabel.text = "Ordered"
            cell.dataLabel.text = "12.04.2023"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cellForData
            cell.isUserInteractionEnabled = false
            cell.namelabel.text = "2 items: Total (Including Delivery)"
            cell.dataLabel.text = "$650"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! cellForProduct
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0, 1: return 50
        default: return 160
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
}

class cellForData: UITableViewCell {
    let namelabel: UILabel = {
        let label = UILabel()
//        label.text = "Ordered"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let dataLabel: UILabel = {
        let label = UILabel()
//        label.text = "24.12.2023"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [namelabel, dataLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            namelabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            namelabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            dataLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dataLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class cellForProduct: UITableViewCell {
    let image: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sneakers2")
        return view
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.text = "New Balance"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Кроссовки 993 Brown из коллаборации с Aimé Leon Dore"
        label.numberOfLines = 0
        return label
    }()
    
    let itemPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.text = "4 • $1234"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [name, image, descriptionLabel, itemPriceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 140),
            image.widthAnchor.constraint(equalToConstant: 140),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            name.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 16),
            name.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            name.rightAnchor.constraint(equalTo: rightAnchor, constant: -18),
            
            itemPriceLabel.leftAnchor.constraint(equalTo: name.leftAnchor),
            itemPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -44),
            
            descriptionLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 2),
            descriptionLabel.leftAnchor.constraint(equalTo: name.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: name.rightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
