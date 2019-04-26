//
//  CCMyProfileCoordinator.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 17/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import UIKit

class CCMyProfileCoordinator: Coordinator {
    static let storyboardId = "MyProfile"
    

    func show(_ vc : [UIViewController]){
        navigator?.setViewControllers(vc , animated: false)
    }
    
    func start(){
        navigator?.setViewControllers([viewController()] as [UIViewController], animated: false)
    }
    
    func viewController() -> CCMyProfileViewController {
        let vc : CCMyProfileViewController = UIStoryboard(name: CCMyProfileCoordinator.storyboardId, bundle: nil).instantiateInitialViewController() as! CCMyProfileViewController
        vc.viewModel = CCMyProfileViewModel(self)
        return vc
    }
    
}
