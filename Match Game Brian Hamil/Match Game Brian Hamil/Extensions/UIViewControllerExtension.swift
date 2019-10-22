//
//  UIViewControllerExtension.swift
//  Match Game Brian Hamil
//
//  Created by user159467 on 10/3/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import UIKit

extension UIViewController {
    func replace(current: UIViewController,
                 with newController: UIViewController,
                 animationDuration duration: TimeInterval,
                 setup: ((_ new: UIViewController) -> Void)? = nil,
                 prepare: ((_ current: UIViewController, _ new: UIViewController) -> Void)? = nil,
                 animationTransition animation: ((_ current: UIViewController, _ new: UIViewController) -> Void)?,
                 completion: ((Bool) -> Void)? = nil) {
        
        current.willMove(toParent: nil)
        newController.willMove(toParent: self)
        self.addChild(newController)
        setup?(newController)
        self.view.addSubview(newController.view)
        newController.view.pinFullscreen(to: self.view)
        prepare?(current, newController)
        newController.view.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            animation?(current, newController)
        }, completion: { complete in
            current.view.removeFromSuperview()
            current.removeFromParent()
            current.didMove(toParent: nil)
            newController.didMove(toParent: self)
            completion?(complete)
        })
    }
    
    func doSomeWork(with first: String, second: String) -> String {
        return ""
    }
}
