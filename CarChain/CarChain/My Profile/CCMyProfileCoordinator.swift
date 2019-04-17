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
    
    func start(){
        let vc = [UIStoryboard(name: CCMyProfileCoordinator.storyboardId, bundle: nil).instantiateInitialViewController()]
        navigator?.setViewControllers(vc as! [UIViewController], animated: false)
    }
    func show(_ vc : [UIViewController]){
        navigator?.setViewControllers(vc , animated: false)
    }
}
