//
//  ViewController.swift
//  RippleTransaction
//
//  Created by ftp27 on 07/08/2017.
//  Copyright (c) 2017 ftp27. All rights reserved.
//

import UIKit
import RippleTransition

class ViewController: UIViewController, UIViewControllerTransitioningDelegate  {
    
    let label: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Hello, world!"
        label.font = UIFont.systemFont(ofSize: 40, weight: UIFontWeightBold)
        return label
    }()
    
    lazy var touchView:UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    func didTapOnView(_ sender: UITapGestureRecognizer) {
        present(RippleEffectVC(fromPoint: sender.location(in: touchView)),
                animated: false) {
                    self.updateStyle()
        }
        
    }
    
    func updateStyle() {
        let newColor = UIColor.random
        view.backgroundColor = newColor
        label.textColor = newColor.reverse//white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        
        view.addSubview(touchView)
        touchView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(didTapOnView(_:))))
        updateStyle()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        touchView.frame = view.frame
        label.sizeToFit()
        label.center = view.center
        
    }
}

extension UIColor {
    class var randomComponent: CGFloat {
        return CGFloat(arc4random()%255) / 255
    }
    
    class var random: UIColor {
        return UIColor(red: randomComponent, green: randomComponent, blue: randomComponent, alpha: 1)
    }
    
    var reverse: UIColor {
        var a: CGFloat = 0
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: 1-r, green: 1-g, blue: 1-b, alpha: a)
    }
}

