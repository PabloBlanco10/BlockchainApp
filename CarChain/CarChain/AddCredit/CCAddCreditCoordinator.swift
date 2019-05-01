//
//  CCAddCreditCoordinator.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 27/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import UIKit

class CCAddCreditCoordinator: Coordinator {
    static let storyboardId = "AddCredit"
    
    func show(_ vc : [UIViewController]){
        navigator?.setViewControllers(vc , animated: false)
    }
    
    func start(){
        navigator?.setViewControllers([viewController()] as [UIViewController], animated: false)
    }
    
    func viewController() -> CCAddCreditViewController {
        let vc = UIStoryboard(name: CCAddCreditCoordinator.storyboardId, bundle: nil).instantiateInitialViewController() as! CCAddCreditViewController
        vc.viewModel = CCAddCreditViewModel(self)
        return vc
    }
}
