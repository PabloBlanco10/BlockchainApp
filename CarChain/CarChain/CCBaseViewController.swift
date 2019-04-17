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
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
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
        setTopBarOpaque()
    }
    
    @IBAction func buttonReturnPressed(_ sender: Any) {
        self.view.window?.fadeTransition(0.2)
        if isModal {dismiss(animated: false, completion: nil)}
        else{navigationController?.popViewController(animated: false)}
    }
    
    func increaseButtonReturnTouchableArea () {
        returnButton?.transform = CGAffineTransform(scaleX: 2, y: 2)
        if isModal {returnButton?.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3.5, bottom: 3, right: 3.5)}
        else {returnButton?.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)}
    }
    
    func setTopBarOpaque() {
        //        statusBar?.tintColor = UIColor.lightGray.withAlphaComponent(0.5)
        statusBar?.tintColor = k.CCCOLORGREEN
        titleView?.backgroundColor = k.CCCOLORGREEN
        titleView?.addShadow(UIColor.gray, 0.05, 5, 10)
        returnButton?.setImageColor(color: UIColor.white)
    }
    
    func setTopBarTransparent() {
        titleView?.backgroundColor = UIColor.clear
        //        backGroundButtonBack?.roundCorners(corners: [.bottomRight], radius: 8)
        returnButton?.setImageColor(color: UIColor.white)
    }
    
    func setRefresher(_ collection : UICollectionView){
        refresher = UIRefreshControl()
        collection.alwaysBounceVertical = true
        refresher.tintColor = k.CCCOLORGREEN
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collection.refreshControl = refresher
    }
    
    @objc func refreshData() {
        self.refresher.endRefreshing()
    }
    
    func showErrorAlert(){
        showSimpleAlertTitleMessage("Error", "Something is wrong. Please check the data", "OK")
    }
    
    func showAlertWithTwoButtons(_ title: String, _ message : String, _ titleAction1 : String, _ titleAction2 : String, _ vc : CCBaseViewController, _ action1 : @escaping (() -> Void), _ action2 : @escaping (() -> Void)){
        
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alertController.view.tintColor = k.CCCOLORGREEN
        let action1 = UIAlertAction(title: titleAction1, style: .default) { (action:UIAlertAction) in
            action1()
        }
        let action2 = UIAlertAction(title: titleAction2, style: .default) { (action:UIAlertAction) in
            action2()
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        vc.present(alertController, animated: true, completion: nil)
    }
    
//    func showLoading(_ v : UIView, _ f : CGPoint){
//        self.loaderBackView.frame = v.frame
//        v.addSubview(self.loaderBackView)
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.loaderBackView.frame
//        blurEffectView.alpha = 1.0
//        self.loaderBackView.addSubview(blurEffectView)
//        self.loading?.stopAnimating()
//        self.loading = nil
//
//        self.loading = NVActivityIndicatorView(frame: CGRect(x: f.x - 25, y: f.y - 25, width: 50, height: 50) , type: .circleStrokeSpin, color: k.FLCOLORORANGE, padding: nil)
//        v.addSubview(self.loading!)
//        self.loading?.startAnimating()
//    }
//
//    func hideLoading(){
//        self.loading?.stopAnimating()
//        self.loaderBackView.removeFromSuperview()
//        self.loading = nil
//    }
}


