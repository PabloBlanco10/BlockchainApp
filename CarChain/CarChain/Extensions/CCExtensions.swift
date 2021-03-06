//
//  CCExtensions.swift
//  CarChain
//
//  Created by Pablo Blanco Peris on 17/04/2019.
//  Copyright © 2019 Pablo Blanco Peris. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension UIViewController{
    func showSimpleAlertTitleMessage(_ title : String , _ message : String, _ button : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func animationsFunctionWithFinishAction(_ duration : CFTimeInterval, _ finishAction : @escaping ()->(), _ animationAction : @escaping ()->()) {
        CATransaction.begin() ; CATransaction.setAnimationDuration(duration)
        CATransaction.setCompletionBlock {DispatchQueue.main.asyncAfter(deadline: .now()) {finishAction()}}
        let transition = CATransition() ; transition.type = .fade
        animationAction()
        CATransaction.commit()
    }
}

extension UIButton {
    func setImageColor(color: UIColor) {
        let templateImage = self.image(for: .normal)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.setImage(templateImage, for: .normal)
        self.tintColor = color
    }
}

extension UIView{
    func addShadow(_ color: UIColor, _ opacity : Float, _ height : Int, _ radius : CGFloat){layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize.init(width: 0, height: height)
        layer.shadowColor =  color.cgColor
        layer.shadowRadius = radius
    }
    
    func fadeTransition(_ time:Double) {
        self.layer.removeAnimation(forKey: kCATransition)
        let transition = CATransition()
        transition.duration = time
        transition.type = CATransitionType.fade
        self.layer.add(transition, forKey: kCATransition)
    }
    
    func animateViews(_ start: CGAffineTransform, _ final: CGAffineTransform, _ alpha1: CGFloat, _ alpha2: CGFloat, _ duration : TimeInterval){
        self.transform = start ; self.alpha = alpha1
        UIView.animate(withDuration: duration, animations: {self.transform = final; self.alpha = alpha2})
    }
    
    func addShadowAndCornerRadius(_ color: UIColor, _ opacity : Float){
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize.init(width: 0, height: 5)
        layer.shadowColor =  color.cgColor
        layer.shadowRadius = 20.0
        layer.cornerRadius = 8.0
    }
}

class CCTitleView : UIView{
    override func awakeFromNib() {
        layer.shadowColor = k.CCCOLORGREEN.cgColor
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.30
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPlate() -> Bool {
        let emailRegEx = "[0-9]{4}+[A-Z]{3}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

extension UIAlertController {
    func show(){
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        self.addAction(ok)
        AppCoordinator.topNavigator()?.viewControllers.last?.present(self, animated: true, completion: nil)
    }
}

var vSpinner : UIView?
extension UIViewController {
    func showLoader() {
        let spinnerView = UIView.init(frame: view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}

class CCButton : UIButton {
    
    override func awakeFromNib() {
        self.addShadow(UIColor.black, 0.8, 0, 2)
        self.backgroundColor = k.CCCOLORGREEN
        self.layer.cornerRadius = 8
    }
    
}
