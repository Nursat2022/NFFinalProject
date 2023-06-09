//
//  SizeViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 07.06.2023.
//

import UIKit

class SizeViewController: UIViewController {

    let SaveButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Save changes", for: .normal)
        return button
    }()

    let sizeField: TextField = {
        let textField = TextField()
        textField.placeholder = "\(shoeSize)"
        textField.keyboardType = .decimalPad
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        view.backgroundColor = .white

        [sizeField, SaveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationItem.title = "Shoe Size"

        SaveButton.addTarget(self, action: #selector(submit(_:)), for: .touchUpInside)

        NSLayoutConstraint.activate([
            sizeField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            sizeField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            sizeField.topAnchor.constraint(equalTo: view.topAnchor, constant: h * CGFloat(104/844.0)),
            sizeField.heightAnchor.constraint(equalToConstant: 48),

            SaveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            SaveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            SaveButton.heightAnchor.constraint(equalToConstant: 54),
            SaveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -h * CGFloat(100/844.0))
        ])
    }
}

extension SizeViewController {
    @objc func submit(_ sender: UIButton) {
        if sizeField.text != "" {
            shoeSize = Double(sizeField.text!)!
        }
    }
}
