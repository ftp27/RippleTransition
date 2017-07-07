//
//  RipplePresentAnimationController.swift
//  Pods
//
//  Created by ftp27 on 08/07/2017.
//
//

import UIKit

public class RipplePresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    public var sourcePoint: CGPoint?
    
    public init(fromPoint point: CGPoint) {
        sourcePoint = point
    }
    
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to) else {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                return
        }
        
        let duration = transitionDuration(using: transitionContext)
        
        let frame = toVC.view.frame
        let center = sourcePoint ?? toVC.view.center
        
        let anim = CABasicAnimation(keyPath: "path")
        
        anim.fromValue = path(fromPoint: center,
                              withRadius: 1,
                              frame: frame)
        anim.toValue = path(fromPoint: center,
                            withRadius: max(frame.width, frame.height),
                            frame: frame)
        anim.duration = duration
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        let layer = CAShapeLayer()
        layer.fillRule = kCAFillRuleEvenOdd
        layer.add(anim, forKey: nil)
        
        fromVC.view.layer.mask = layer
        
        DispatchQueue.global().asyncAfter(deadline: .now() + duration) {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func path(fromPoint point: CGPoint, withRadius radius: CGFloat, frame: CGRect) -> CGPath {
        let path = CGMutablePath()
        path.addEllipse(in: CGRect(origin: CGPoint(x: point.x - radius,
                                                   y: point.y - radius),
                                   size: CGSize(width: radius*2,
                                                height: radius*2)))
        path.addRect(frame)
        
        return path
    }
}
