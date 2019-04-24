//
//  CCLateralMenuViewController.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 17/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum lateralMenuState {
    case hide
    case show
}

class CCLateralMenuViewController: CCBaseViewController {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var lateralMenuContainer: UIView!
    @IBOutlet weak var mainViewContainer: UIView!
    
    @IBOutlet weak var viewToPanMenu: UIView!
    var menuState = lateralMenuState.hide{
        didSet{
            if menuState == .hide{
                animationsFunctionWithFinishAction(0.6, {self.mainViewContainer.layer.cornerRadius = 0.0; (self.children.last)?.view.isUserInteractionEnabled = true}, {self.animateHideMenu()})
                viewToPanMenu.frame = CGRect(x: 0, y: 0, width: 0, height: UIScreen.main.bounds.height)
                shadowView.isHidden = true
            }
            if menuState == .show{
                animationsFunctionWithFinishAction(0.6, {(self.children.last)?.view.isUserInteractionEnabled = false}, {self.animateShowMenu();})
                viewToPanMenu.frame = mainViewContainer.frame
                shadowView.frame = viewToPanMenu.frame
                shadowView.isHidden = false
            }
        }
    }
    
    let animationShowMenu = CGAffineTransform(scaleX: 0.75, y: 0.75).concatenating(CGAffineTransform(translationX: UIScreen.main.bounds.width/2, y: 0))
    
    lazy var newWidth = UIScreen.main.bounds.width/2 + mainViewContainer.bounds.size.width * 0.2 - 10
    lazy var newHeight = mainViewContainer.bounds.size.height * 0.8 + 60
    
    lazy var animationShowButton = CGAffineTransform(scaleX: 1.0, y: 1.0).concatenating(CGAffineTransform(translationX: newWidth, y: UIScreen.main.bounds.height - newHeight))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.addShadowAndCornerRadius(UIColor.gray, 0.8)
        setConfiguration()
        AppNavigator.source(self.children.last as? UINavigationController, goTo: .map)
        addViewWithGestures()
    }
    
    func addViewWithGestures(){
        let tapGesture = UITapGestureRecognizer()
        let panGesture = UIPanGestureRecognizer()
        
        viewToPanMenu.addGestureRecognizer(tapGesture)
        viewToPanMenu.addGestureRecognizer(panGesture)
        
        panGesture.rx.event.bind(onNext: { recognizer in
            let direction = recognizer.velocity(in: self.viewToPanMenu)
            
            if direction.x > 650 && self.menuState == .hide{
                self.menuState = .show
            }
            else if direction.x < (-650) && self.menuState == .show{
                self.menuState = .hide
            }
            
        }).disposed(by: disposeBag)
        
        tapGesture.rx.event.bind(onNext: { recognizer in
            if self.menuState == .show {
                self.menuState = .hide
            }
            
        }).disposed(by: disposeBag)
    }
    
    func setConfiguration(){
        menuButton.rx.tap
            .subscribe{next in
                if self.menuState == .hide{self.menuState = .show}
                else{self.menuState = .hide}
            }.disposed(by: disposeBag)
    }
    
    func animateShowMenu(){
        mainViewContainer.addShadowAndCornerRadius(UIColor.gray, 1.0)
        mainViewContainer.animateViews(.identity, animationShowMenu, 1.0, 1.0, 0.3)
        menuButton.animateViews(.identity, animationShowButton, 1.0, 1.0, 0.3)
    }
    
    func animateHideMenu(){
        mainViewContainer.animateViews(animationShowMenu, .identity, 1.0, 1.0, 0.3)
        menuButton.animateViews( animationShowButton, .identity, 1.0, 1.0, 0.3)
    }
    
}

