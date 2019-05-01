//
//  LoginViewModel.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 23/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Firebase

class CCLoginViewModel {
    
    let coordinator : CCLoginCoordinator?
    var username = Variable<String>("")
    var password = Variable<String>("")
    
    init(_ coordinator:CCLoginCoordinator?) { self.coordinator = coordinator ; checkUserSaved() }
    
    func checkUserSaved(){
        if UserDefaults.standard.bool(forKey: k.UserDefaults.userRegistered){
            username.value = UserDefaults.standard.value(forKey: k.UserDefaults.username) as! String
            password.value = UserDefaults.standard.value(forKey: k.UserDefaults.password) as! String
        }
    }
    
    func loginButtonAction(_ vc : CCLoginViewController){
        if !username.value.isEmpty && !password.value.isEmpty{
            vc.showLoader()
            Auth.auth().signIn(withEmail: username.value, password: password.value) { (user, error) in
                vc.hideLoader()
                guard let user = user?.user else {self.showError(); return}
                self.loginSuccess(user)
            }
        }
        else{ UIAlertController(title: "Error", message: "Data missing", preferredStyle: .alert).show() }
    }
    
    func loginSuccess(_ user: User){
        UserDefaults.standard.set(true, forKey: k.UserDefaults.userRegistered)
        UserSession.sharedInstance.saveUser(user, username.value, password.value)
        coordinator?.navigateToMap()
    }
    
    func showError(){
        UIAlertController(title: "Error", message: "User/password incorrect", preferredStyle: .alert).show()
    }
    
    func registerButtonPressed(){
        coordinator?.navigateToRegister()
    }
}
