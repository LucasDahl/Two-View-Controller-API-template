//
//  transparentButton.swift
//  Shade
//
//  Created by Lucas Dahl on 2/28/21.
//

import UIKit

class transparentButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        setupButton()
    }
    
    // Setup the button
    func setupButton() {
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(red: 203, green: 72, blue: 75, alpha: 1)
        self.layer.borderColor = UIColor(white: 1.0, alpha: 0.25).cgColor
        self.alpha = 0.75
    }
    

}
