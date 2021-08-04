//
//  SKSimpleTransition.swift
//  SimpleTransition
//
//  Created by don chen on 2017/2/13.
//  Copyright © 2017年 Don Chen. All rights reserved.
//

import UIKit

class RightFadeOutTransition:NSObject, UIViewControllerAnimatedTransitioning {
    
    // 定義轉場動畫
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    // 具體的轉場動畫
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC?.view
        
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView!)
        
        // 轉場動畫
        transitionContext.containerView.bringSubviewToFront(fromView!)
        fromView?.alpha = 1
        toView?.alpha = 1
        fromView?.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
        
        
        UIView.animate(withDuration: 0.2, animations: {
            fromView?.frame = CGRect(x:UIScreen.main.bounds.width,y:0,width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
            //fromView?.alpha = 1
        }, completion: { finished in
            //transitionContext.containerView.bringSubviewToFront(fromView!)
            transitionContext.completeTransition(true)
            
        })
        
        
        //二段式sample
        /*
        UIView.animate(withDuration: 0.8, animations: {
            //fromView?.alpha = 0.5
            fromView?.frame = CGRect(x:UIScreen.main.bounds.width,y:0,width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
            
        }, completion: { finished in
            UIView.animate(withDuration: 0.4, animations: {
                //toView?.alpha = 1
                
            }, completion: { finished in
                // 通知完成轉場
                transitionContext.completeTransition(true)
            })
            
        })
        */
    }
}
