//
//  CCRegisterCoordinator.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 23/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import UIKit

class CCRegisterCoordinator : Coordinator {
    
    static let storyboardId = "Login"
    static let vcId = "Register"

    func start(){
        navigator?.pushViewController(viewController(), animated: true)
//        navigator?.setViewControllers([viewController()] as [UIViewController], animated: false)
    }
    
    func viewController() -> CCRegisterViewController {
        let vc : CCRegisterViewController = UIStoryboard(name: CCRegisterCoordinator.storyboardId, bundle: nil).instantiateViewController(withIdentifier: CCRegisterCoordinator.vcId) as! CCRegisterViewController
        vc.viewModel = CCRegisterViewModel(self)
        return vc
    }
    
    
    func show(_ vc : [UIViewController]){
        navigator?.setViewControllers(vc , animated: false)
    }
}
