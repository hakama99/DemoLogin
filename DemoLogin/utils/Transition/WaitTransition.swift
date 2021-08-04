//
//  SKSimpleTransition.swift
//  SimpleTransition
//
//  Created by don chen on 2017/2/13.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class WaitTransition:NSObject, UIViewControllerAnimatedTransitioning {
    
    // 定義轉場動畫
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 4
    }
    
    // 具體的轉場動畫
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC?.view
        
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView!)
        print("aaa")
        // 轉場動畫
        fromView?.alpha = 1
        toView?.alpha = 1
        UIView.animate(withDuration: 4, animations: {
            fromView?.alpha = 0.999
        }, completion: { finished in
            transitionContext.completeTransition(true)
            print("bbb")
        })
        
        
    }
}
