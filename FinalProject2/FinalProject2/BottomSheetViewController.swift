//
//  BottomSheetViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 07.06.2023.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    lazy var vectorImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "vector7")
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    
    lazy var circleImage2: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ellipse2")
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    
    lazy var circleImage1: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ellipse1")
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Your order is succesfully placed. Thanks!"
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var button: CustomButton = {
        let button = CustomButton()
        button.setTitle("Get back to shopping", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(getBack(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        view.addSubview(circleImage1)
        view.addSubview(circleImage2)
        view.addSubview(vectorImage)
        view.addSubview(label)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            vectorImage.topAnchor.constraint(equalTo: view.topAnchor),
            vectorImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            vectorImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * CGFloat(346/390.0)),
            vectorImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * CGFloat(153/844.0)),
            
            circleImage1.widthAnchor.constraint(equalToConstant: 160),
            circleImage1.heightAnchor.constraint(equalToConstant: 160),
            circleImage1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIScreen.main.bounds.width * CGFloat(56/390.0)),
            circleImage1.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * CGFloat(54/844.0)),
            
            circleImage2.widthAnchor.constraint(equalToConstant: 160),
            circleImage2.heightAnchor.constraint(equalToConstant: 160),
//            circleImage2.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: UIScreen.main.bounds.height/2 * CGFloat(10/269.0)),
//            circleImage2.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: -UIScreen.main.bounds.width/2 * CGFloat(21/195.0)),
            circleImage2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -UIScreen.main.bounds.width * CGFloat(56/390.0)),
            circleImage2.topAnchor.constraint(equalTo: circleImage1.topAnchor, constant: 40),
            
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIScreen.main.bounds.height * CGFloat(50/844.0)),
            button.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * CGFloat(58/844.0)),

//            label.topAnchor.constraint(equalTo: circleImage2.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -24),
        ])
        
        
    }
}

//extension BottomSheetViewController {
//    @objc func getBack(_ sender: UIButton) {
//        print(self.parent)
//        self.presentingViewController?.dismiss(animated: true, completion: nil)
//    }
//}
