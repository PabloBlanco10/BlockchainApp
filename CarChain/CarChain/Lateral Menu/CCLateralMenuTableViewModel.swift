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
    private let privateDataSourceManager: Variable<[String]> = Variable(["Map", "My Profile", "Register Cars"])

    private let disposeBag = DisposeBag()
    
    // MARK: Outputs
    public let dataSource: Observable<[String]>
    
    var mapVC : CCMapViewController?
    var myProfileVC : CCMyProfileViewController?

    init() {
        dataSource = privateDataSource.asObservable()
        if UserSession.sharedInstance.isManager{privateDataSource.value = privateDataSourceManager.value}
    }
    
    func logoutButtonPressed(){
        UserDefaults.standard.set(false, forKey: k.userRegistered)
        AppDelegate.appCoordinator?.start()
    }

    func navigateTo(_ index : Int, _ navigation : UINavigationController){
        switch index {
        case 0:
            if let vc = mapVC{AppNavigator.goTo(navigation, goTo: .map, vc)}
            else{AppNavigator.source(navigation, goTo: .map)}
        case 1:
            if let vc = myProfileVC{AppNavigator.goTo(navigation, goTo: .myprofile, vc)}
            else{AppNavigator.source(navigation, goTo: .myprofile)}
        default:
            print(index)
        }
    }
}
