//
//  CCRegisterViewController.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 23/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import UIKit

class CCRegisterViewController : CCBaseViewController {
    
    var viewModel : CCRegisterViewModel?
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setStyles()
    }
    
    func bindViewModel(){
        
    }
    
    func setStyles(){
        registerButton.addShadow(UIColor.black, 0.8, 0, 2)
        registerButton.backgroundColor = k.CCCOLORGREEN
        registerButton.layer.cornerRadius = 8
    }
}
