//
//  RippleEffectVC.swift
//  Pods
//
//  Created by ftp27 on 08/07/2017.
//
//

import UIKit

public class RippleEffectVC: UIViewController, UIViewControllerTransitioningDelegate {
    
    var transition: RipplePresentAnimationController?
    
    public init(fromPoint point: CGPoint) {
        transition = RipplePresentAnimationController(fromPoint: point)
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        transitioningDelegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    public func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.layer.contents = screenShot?.cgImage
        
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var screenShot: UIImage? {
        guard let window = UIApplication.shared.delegate?.window else { return nil }
        UIGraphicsBeginImageContext(view.bounds.size)
        window!.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

