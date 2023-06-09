//
//  ProfileViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 07.06.2023.
//

import UIKit
import SafariServices
import FirebaseAuth

class ProfileViewController: UIViewController {
    let tableView = UITableView()
    
    let sections = [["Account information"], ["Order History"], ["Shoe size"], ["How to know your shoe size?", "How to check the authenticity of\nthe shoe?"]]
    let links = ["https://www.rivir.in/pages/know-you-shoe-size", "https://hypestew.com/blogs/news/legit-check"]
    
    lazy var button: CustomButton = {
        let button = CustomButton()
        button.setTitle("Sign out", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(confirm(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Cart"
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = view.backgroundColor
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CellForLink.self, forCellReuseIdentifier: "cellForLink")
        view.addSubview(tableView)
        view.addSubview(button)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: h * CGFloat(114/844.0)),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -h * CGFloat(100/844.0)),
            button.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    func addAlert() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) {_ in
            let loader = loader(viewController: self)
            do {
                try Auth.auth().signOut()
                orders = [:]
                orderHistory = []
                numberOfOrders = 0
                let transition = CATransition()
                transition.duration = 0.3
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                
                stopLoader(loader: loader)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    UIApplication.shared.keyWindow?.layer.add(transition, forKey: nil)
                    UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: WelcomeViewController())
                }
            }
            catch {
                stopLoader(loader: loader)
                print("error")
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        alertController.view.tintColor = .black
        present(alertController, animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == sections.count - 1 && indexPath.row == 1 ? 74 : 52
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellForLink", for: indexPath) as! CellForLink
            cell.label.text = sections[indexPath.section][indexPath.row]
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
            if indexPath.section == 2 {
                let sizeLabel = UILabel()
                sizeLabel.textColor = .gray
                sizeLabel.translatesAutoresizingMaskIntoConstraints = false
                sizeLabel.text = "\(shoeSize)"
                cell.sizeLabel = sizeLabel
                cell.addSubview(cell.sizeLabel!)
                    NSLayoutConstraint.activate([
                        cell.sizeLabel!.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
                        cell.sizeLabel!.rightAnchor.constraint(equalTo: cell.icon.leftAnchor, constant: -10),
                    ])
            }
            cell.label.text = sections[indexPath.section][indexPath.row]
//            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = view.backgroundColor
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) as? CellForLink {
            guard let url = URL(string: "\(links[indexPath.row])") else {return}
            
            if UIApplication.shared.canOpenURL(url) {
                let safariVC = SFSafariViewController(url: url)
                present(safariVC, animated: true)
            } else {
                print("Cannot open URL: \(url)")
            }
        }
        else {
            var vc: UIViewController
            switch indexPath.section {
            case 0:
                vc = AccountViewController()
            case 1:
                vc = HistoryViewController()
            case 2:
                vc = SizeViewController()
            default:
                return
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ProfileViewController {
    @objc func confirm(_ sender: UIButton) {
        addAlert()
    }
}

class CustomCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let icon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        view.tintColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.3)
        return view
    }()
    
    var sizeLabel: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        addSubview(icon)
        label.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CellForLink: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let linkImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "link")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        addSubview(linkImage)
        label.translatesAutoresizingMaskIntoConstraints = false
        linkImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            linkImage.heightAnchor.constraint(equalToConstant: 16),
            linkImage.widthAnchor.constraint(equalToConstant: 16),
            linkImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            linkImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

