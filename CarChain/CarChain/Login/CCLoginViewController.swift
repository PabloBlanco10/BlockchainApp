//
//  LoginViewController.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 23/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import UIKit

class CCLoginViewController : CCBaseViewController {
    
    var viewModel : CCLoginViewModel?
    
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setStyles()
    }
    
    func bindViewModel(){
        viewModel?.username.asObservable().bind(to: usernameTextfield.rx.text).disposed(by: disposeBag)
        usernameTextfield.rx.text.orEmpty.bind(to:viewModel!.username).disposed(by: disposeBag)
        viewModel?.password.asObservable().bind(to: passwordTextfield.rx.text).disposed(by: disposeBag)
        passwordTextfield.rx.text.orEmpty.bind(to: viewModel!.password).disposed(by: disposeBag)
        
        _ = loginButton.rx.tap.subscribe(){
            value in self.viewModel?.loginButtonAction()
        }
        _ = registerButton.rx.tap.subscribe(){value in self.viewModel?.registerButtonPressed()}
    }
    
    func setStyles(){
        loginButton.addShadow(UIColor.black, 0.8, 0, 2)
        loginButton.backgroundColor = k.CCCOLORGREEN
        loginButton.layer.cornerRadius = 8
    }
}
