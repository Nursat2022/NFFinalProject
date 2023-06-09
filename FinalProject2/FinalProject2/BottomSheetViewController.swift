//
//  BottomSheetViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 07.06.2023.
//

import UIKit

class BottomSheetViewController: UIViewController {
    weak var delegate: BottomSheetViewControllerDelegate?
    
    lazy var vectorImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "vector7")
        return view
    }()
    
    lazy var circleImage2: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ellipse2")
        return view
    }()
    
    lazy var circleImage1: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ellipse1")
        return view
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.bottomSheetViewControllerDismissed()
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Your order is succesfully placed. Thanks!"
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var button: CustomButton = {
        let button = CustomButton()
        button.setTitle("Get back to shopping", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        [circleImage1, circleImage2, vectorImage, label, button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            vectorImage.topAnchor.constraint(equalTo: view.topAnchor),
            vectorImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            vectorImage.widthAnchor.constraint(equalToConstant: w * CGFloat(346/390.0)),
            vectorImage.heightAnchor.constraint(equalToConstant: h * CGFloat(153/844.0)),
            
            circleImage1.widthAnchor.constraint(equalToConstant: w * (160/390.0)),
            circleImage1.heightAnchor.constraint(equalToConstant: w * (160/390.0)),
            circleImage1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIScreen.main.bounds.width * CGFloat(56/390.0)),
            circleImage1.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * CGFloat(54/844.0)),
            
            circleImage2.widthAnchor.constraint(equalToConstant: w * (160/390.0)),
            circleImage2.heightAnchor.constraint(equalToConstant: w * (160/390.0)),
//            circleImage2.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: UIScreen.main.bounds.height/2 * CGFloat(10/269.0)),
//            circleImage2.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: -UIScreen.main.bounds.width/2 * CGFloat(21/195.0)),
            circleImage2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -UIScreen.main.bounds.width * CGFloat(56/390.0)),
            circleImage2.topAnchor.constraint(equalTo: circleImage1.topAnchor, constant: h * (40/844.0)),
            
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -h * CGFloat(50/844.0)),
            button.heightAnchor.constraint(equalToConstant: h * CGFloat(58/844.0)),

//            label.topAnchor.constraint(equalTo: circleImage2.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -h * CGFloat(24/844.0)),
        ])
    }
    
    @objc private func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
           let translation = gestureRecognizer.translation(in: view)
           let velocity = gestureRecognizer.velocity(in: view)
           
           if gestureRecognizer.state == .ended {
               // Check if the swipe was downward and with sufficient velocity
               if translation.y > 0 && velocity.y > 1000 {
                   dismiss(animated: true) {
                       self.delegate?.bottomSheetViewControllerDismissed()
                   }
               }
           }
       }
}

protocol BottomSheetViewControllerDelegate: AnyObject {
    func bottomSheetViewControllerDismissed()
}

//extension BottomSheetViewController {
//    @objc func getBack(_ sender: UIButton) {
//        print(self.parent)
//        self.presentingViewController?.dismiss(animated: true, completion: nil)
//    }
//}
