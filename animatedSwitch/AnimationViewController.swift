//
//  AnimationViewController.swift
//  animatedSwitch
//
//  Created by shishir sapkota on 10/21/18.
//  Copyright © 2018 shishir sapkota. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    var point: CGPoint? {
        didSet {
//            self.animate(center: point)
            self.addCircleAnimation(point: point)
//            self.addCircleAnimation(center: point)
        }
    }

    @IBOutlet weak var bgView: UIView!
    
    let layer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.bgView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        self.point = sender.location(in: view)
    }
    
    
    func addCircleAnimation(point: CGPoint?) {
        guard let center = point else {
            return
        }
        
        let circleView = UIView(frame: CGRect.init(x: 0, y: 0, width: 5, height: 5))
        circleView.center = center
        circleView.layer.cornerRadius = circleView.bounds.width/2
        circleView.backgroundColor = UIColor.blue
        self.bgView.addSubview(circleView)
        let p = self.view.bounds.width
        let b = self.view.bounds.height
        let rSquare = pow(p, 2) + pow(b, 2)
        let r = sqrt(rSquare)
//
        
        
        UIView.animate(withDuration: 0.6, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            circleView.transform = CGAffineTransform.init(scaleX: r, y: r)
        }) { (_) in
            self.bgView.backgroundColor = UIColor.blue
            circleView.removeFromSuperview()
        }
    
    }

    func animate(center: CGPoint?) {
        guard let center = center else {
            return
        }
        let initialPath = UIBezierPath.init(arcCenter: center, radius: 10, startAngle: 0, endAngle: 360, clockwise: true)
        let finalPath = UIBezierPath.init(arcCenter: center, radius: 500, startAngle: 0, endAngle: 360, clockwise: true)
        self.layer.path = initialPath.cgPath
        layer.opacity = 1
        let animation = CABasicAnimation.init(keyPath: "path")
        animation.duration = 1
//        animation.fromValue = initialPath.cgPath
        animation.toValue = finalPath.cgPath
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.autoreverses = false
        animation.delegate = self
        layer.add(animation, forKey: "path")
        
        self.bgView.layer.mask = layer
    }
}


extension AnimationViewController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        print("animation started")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animation stopped")
    }
}
