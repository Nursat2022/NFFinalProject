//
//  CustomButton.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        tintColor = .white
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 27
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
}
