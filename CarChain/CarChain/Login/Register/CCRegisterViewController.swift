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
    @IBOutlet weak var registerButton: CCButton!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel(){
        viewModel?.email.asObservable().bind(to: emailTextfield.rx.text).disposed(by: disposeBag)
        emailTextfield.rx.text.orEmpty.bind(to:viewModel!.email).disposed(by: disposeBag)
        viewModel?.password.asObservable().bind(to: passwordTextfield.rx.text).disposed(by: disposeBag)
        passwordTextfield.rx.text.orEmpty.bind(to: viewModel!.password).disposed(by: disposeBag)
        
        _ = registerButton.rx.tap.subscribe(){value in
            self.viewModel?.registerUser(self)
        }
        
        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        _ = tap.rx.event.bind(onNext: { recognizer in
            self.view.endEditing(true)
        })
    }

}
