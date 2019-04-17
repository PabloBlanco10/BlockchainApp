//
//  CCLateralMenuTableViewModel.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 17/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import UserNotifications

class CCLateralMenuTableViewModel {
    
    // MARK: Private properties
    private let privateDataSource: Variable<[String]> = Variable(["Map", "My Profile"])
    private let disposeBag = DisposeBag()
    
    // MARK: Outputs
    public let dataSource: Observable<[String]>
    
    var mapVC : CCMapViewController?
    var myProfileVC : CCMyProfileViewController?

    init() {
        dataSource = privateDataSource.asObservable()
    }

    func navigateTo(_ index : Int, _ navigation : UINavigationController){
        switch index {
        case 0:
            if let vc = mapVC{CCAppNavigator.goTo(navigation, goTo: .map, vc)}
            else{CCAppNavigator.source(navigation, goTo: .map)}
        case 1:
            if let vc = myProfileVC{CCAppNavigator.goTo(navigation, goTo: .myprofile, vc)}
            else{CCAppNavigator.source(navigation, goTo: .myprofile)}
        default:
            print(index)
        }
    }
}
