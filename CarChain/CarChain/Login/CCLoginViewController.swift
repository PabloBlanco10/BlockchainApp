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
    @IBOutlet weak var loginButton: CCButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel(){
        viewModel?.username.asObservable().bind(to: usernameTextfield.rx.text).disposed(by: disposeBag)
        usernameTextfield.rx.text.orEmpty.bind(to:viewModel!.username).disposed(by: disposeBag)
        viewModel?.password.asObservable().bind(to: passwordTextfield.rx.text).disposed(by: disposeBag)
        passwordTextfield.rx.text.orEmpty.bind(to: viewModel!.password).disposed(by: disposeBag)
        _ = loginButton.rx.tap.subscribe(){
            value in self.viewModel?.loginButtonAction(self)
        }
        _ = registerButton.rx.tap.subscribe(){value in self.viewModel?.registerButtonPressed()}
        
        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        _ = tap.rx.event.bind(onNext: { recognizer in
            self.view.endEditing(true)
        })
    }
}
