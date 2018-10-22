//
//  ViewController.swift
//  animatedSwitch
//
//  Created by shishir sapkota on 10/20/18.
//  Copyright © 2018 shishir sapkota. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var headingTitlelabel: UILabel!
    @IBOutlet weak var headingTitleLabel2: UILabel!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var stackView2: UIStackView!
    
    @IBOutlet weak var backgroundLayer: UIView!
    let containerView = UIView()
    
//    let containerView = UICont
    let shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundLayer.layer.addSublayer(shapeLayer)
        self.backgroundLayer.clipsToBounds = true
        self.containerView.frame = self.backgroundLayer.frame
        self.backgroundLayer.insertSubview(containerView, at: 0)

    }
    

    @IBAction func switch1(_ sender: UISwitch) {
        print("touch")
        animate(from: sender.center)
    }
    
    @IBAction func switch2(_ sender: UISwitch) {
        animate(from: sender.center)
    }
    
    func animate(from point: CGPoint?) {
        guard let center = point else {
            return
        }
        
        let circleView = UIView(frame: CGRect.init(x: 0, y: 0, width: 5, height: 5))
        circleView.center = center
        circleView.layer.cornerRadius = circleView.bounds.width/2
        circleView.backgroundColor = UIColor.red
        self.containerView.addSubview(circleView)

        let p = self.view.bounds.width
        let b = self.view.bounds.height
        let rSquare = pow(p, 2) + pow(b, 2)
        let r = sqrt(rSquare)
        //
        
        
        let animator = UIViewPropertyAnimator(duration: 1, curve: UIViewAnimationCurve.easeInOut)
        animator.addAnimations {
            circleView.transform =  CGAffineTransform.init(scaleX: r, y: r)
        }
        
        
        animator.addCompletion { (_) in
            self.backgroundLayer.backgroundColor = UIColor.red
            circleView.removeFromSuperview()
        }
        
        UIView.transition(with: self.headingTitlelabel, duration: 0.33, options: [UIViewAnimationOptions.transitionCrossDissolve, .curveEaseIn], animations: {
            self.headingTitlelabel.textColor = .white
        }, completion: nil)
        
        animator.startAnimation()
    
        
    }
    
}

