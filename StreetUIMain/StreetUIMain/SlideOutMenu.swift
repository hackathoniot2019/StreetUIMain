//
//  SlideOutMenu.swift
//  StreetUIMain
//
//  Created by Denis Abramov on 30/03/2019.
//  Copyright © 2019 Denis Abramov. All rights reserved.
//

import UIKit

class SlideOutMenu: NSObject {
    
    let underView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let imageOfUser: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.customGray
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    let nameOfUser: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 20
        label.backgroundColor = UIColor.customGray
        return label
    }()
    
    let surnameOfUser: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 20
        label.backgroundColor = UIColor.customGray
        return label
    }()
    
    let blackView = UIView()
    
    func configureUnderView() {
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = .black
            blackView.alpha = 0
            window.addSubview(blackView)
            blackView.frame = window.frame
            
            let width = window.frame.width * (0.7)
            let height = window.frame.height
            
            configureMenu(window: window, width: width)
            
            let recognizer = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
            underView.addGestureRecognizer(recognizer)
            
            window.addSubview(underView)
            
            underView.frame = CGRect(x: -width, y: 0, width: width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.underView.frame = CGRect(x: 0, y: 0, width: width, height: height)
                self.blackView.alpha = 0.5
            }, completion: nil)
        }
    }
    
    func configureMenu(window: UIWindow, width: CGFloat) {
        [imageOfUser, nameOfUser, surnameOfUser].forEach {underView.addSubview($0)}
        
        imageOfUser.anchor(top: underView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100, enableInsets: false)
        imageOfUser.centerXAnchor.constraint(equalTo: underView.centerXAnchor).isActive = true
        
        nameOfUser.anchor(top: imageOfUser.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 30, enableInsets: false)
        nameOfUser.centerXAnchor.constraint(equalTo: underView.centerXAnchor).isActive = true
        
        surnameOfUser.anchor(top: nameOfUser.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 30, enableInsets: false)
        surnameOfUser.centerXAnchor.constraint(equalTo: underView.centerXAnchor).isActive = true
        
        
    }
    
    @objc func handleGesture(_ recognizer: UIPanGestureRecognizer) {
        
        if recognizer.state == .began {
            
        } else if recognizer.state == .changed {
            let translation = recognizer.translation(in: underView)
            let newX = underView.frame.origin.x + translation.x
            if newX <= 0 {
                underView.frame = CGRect(x: newX, y: underView.frame.origin.y, width: underView.frame.width, height: underView.frame.height)
                recognizer.setTranslation(.zero, in: underView)
            }
        } else {
            if underView.frame.origin.x <= -(self.underView.frame.width / 2) {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.underView.frame = CGRect(x: -self.underView.frame.width, y: 0, width: self.underView.frame.width, height: self.underView.frame.height)
                    self.blackView.alpha = 0
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.underView.frame = CGRect(x: 0, y: 0, width: self.underView.frame.width, height: self.underView.frame.height)
                    self.blackView.alpha = 0.5
                }, completion: nil)
            }
        }
    }
    
    override init() {
        super.init()
    }
}
