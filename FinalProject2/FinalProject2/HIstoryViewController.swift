//
//  HIstoryViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 08.06.2023.
//

import UIKit

var orderHistory = [orderData(number: 1, date: "24.12.2023", numberOfItems: 5, totalPrice: 1234), orderData(number: 2, date: "24.12.2023", numberOfItems: 3, totalPrice: 1234), orderData(number: 3, date: "24.12.2023", numberOfItems: 5, totalPrice: 1234), orderData(number: 4, date: "24.12.2023", numberOfItems: 5, totalPrice: 1234), orderData(number: 5, date: "24.12.2023", numberOfItems: 2, totalPrice: 3543)]

class HistoryViewController: UIViewController {
    
    var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = view.backgroundColor
        
        tableView.register(OrderCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.barTintColor = .black
        self.title = "Order History"
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 104),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        orderHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderCell
        cell.accessoryType = .disclosureIndicator
        cell.orderLabel.text = "Order #\(orderHistory[indexPath.section].number)"
        cell.dateLabel.text = orderHistory[indexPath.section].date
        cell.itemPriceLabel.text = "\(orderHistory[indexPath.section].numberOfItems) items • $\(orderHistory[indexPath.section].totalPrice)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
}

class OrderCell: UITableViewCell {
    let viewForImages: UIView = {
        let view = threeImages()
        return view
    }()
    
    let orderLabel: UILabel = {
        let label = UILabel()
//        label.text = "Order #123"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
//        label.text = "24.12.2021"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    let itemPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
//        label.text = "4 items • $1234"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [viewForImages, orderLabel, dateLabel, itemPriceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
//        addSubview(viewForImages)
//        addSubview(orderLabel)
    
        NSLayoutConstraint.activate([
            viewForImages.leftAnchor.constraint(equalTo: leftAnchor),
            viewForImages.topAnchor.constraint(equalTo: topAnchor),
            viewForImages.bottomAnchor.constraint(equalTo: bottomAnchor),
            viewForImages.widthAnchor.constraint(equalToConstant: 120),
            
            orderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            orderLabel.leftAnchor.constraint(equalTo: viewForImages.rightAnchor, constant: 10),
            
            dateLabel.topAnchor.constraint(equalTo: orderLabel.bottomAnchor, constant: 2),
            dateLabel.leftAnchor.constraint(equalTo: orderLabel.leftAnchor),
            
            itemPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            itemPriceLabel.leftAnchor.constraint(equalTo: orderLabel.leftAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct orderData {
    var number: Int
    var date: String
    var numberOfItems: Int
    var totalPrice: Int
}