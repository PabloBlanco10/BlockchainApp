//
//  CCBaseViewController.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 17/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CCBaseViewController: UIViewController {
    
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    
    var refresher:UIRefreshControl!
    let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
    lazy var isModal : Bool = {
        if let navigation = navigationController {return false}
        else{return true}
    }()
    let disposeBag = DisposeBag()
    var loaderBackView  =  UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isModal {returnButton?.setImage(#imageLiteral(resourceName: "icon_closed"), for: .normal)}
        else{returnButton?.setImage(#imageLiteral(resourceName: "back"), for: .normal)}
        setTopBarTransparent()
    }
    
    @IBAction func buttonReturnPressed(_ sender: Any) {
//        self.view.window?.fadeTransition(0.2)
        if isModal {dismiss(animated: false, completion: nil)}
        else{navigationController?.popViewController(animated: true)}
    }
    
    func setTopBarOpaque() {
        statusBar?.tintColor = k.CCCOLORGREEN
        topView?.backgroundColor = k.CCCOLORGREEN
        topView?.addShadow(UIColor.gray, 0.05, 5, 10)
        returnButton?.setImageColor(color: UIColor.white)
    }
    
    func setTopBarTransparent() {
        topView?.backgroundColor = UIColor.white
        topView?.addShadow(k.CCCOLORGREEN, 0.7, 5, 10)
        returnButton?.setImageColor(color: UIColor.black)
    }

    func showAlertWithTwoButtons(_ title: String, _ message : String, _ titleAction1 : String, _ titleAction2 : String, _ vc : CCBaseViewController, _ action1 : @escaping (() -> Void), _ action2 : @escaping (() -> Void)){
        
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alertController.view.tintColor = k.CCCOLORGREEN
        let action1 = UIAlertAction(title: titleAction1, style: .default) { (action:UIAlertAction) in action1() }
        let action2 = UIAlertAction(title: titleAction2, style: .default) { (action:UIAlertAction) in action2() }
        alertController.addAction(action1)
        alertController.addAction(action2)
        vc.present(alertController, animated: true, completion: nil)
    }
}


