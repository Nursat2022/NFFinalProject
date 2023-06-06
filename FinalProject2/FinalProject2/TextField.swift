//
//  TextField.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 06.06.2023.
//

import UIKit

class TextField: UITextField {
    
    private let accentColor = UIColor.black

    var padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
       
   override func becomeFirstResponder() -> Bool {
       let didSetFirstResponder = super.becomeFirstResponder()
       
       if didSetFirstResponder {
           layer.borderColor = accentColor.cgColor
           layer.borderWidth = 2.0
       }
       
       return didSetFirstResponder
   }
   
   override func resignFirstResponder() -> Bool {
       let didResignFirstResponder = super.resignFirstResponder()
       
       if didResignFirstResponder {
           layer.borderColor = UIColor.clear.cgColor
       }
       
       return didResignFirstResponder
   }
}

