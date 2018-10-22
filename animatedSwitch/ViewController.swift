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

    @IBOutlet weak var backGroundLayer2: UIView!
    
    @IBOutlet weak var backgroundLayer: UIView!
    let containerView = UIView()
    let containerView2 = UIView()
    var circleView: UIView?
    var circleView2: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundLayer.clipsToBounds = true
        self.backGroundLayer2.clipsToBounds = true
        self.containerView.frame = self.backgroundLayer.frame
        self.containerView2.frame = self.backGroundLayer2.frame
        self.backgroundLayer.insertSubview(containerView, at: 0)
        self.backGroundLayer2.insertSubview(containerView2, at: 0)
        self.switch1.setOn(false, animated: false)
        self.switch2.setOn(false, animated: false)
    }
    

    @IBAction func switch1(_ sender: UISwitch) {
        animate(from: self.switch1.center, expanding: sender.isOn)
    }
    
    @IBAction func switch2(_ sender: UISwitch) {
        animate2(from: self.switch2.center, expanding: sender.isOn)
    }
    
    func animate(from point: CGPoint?, expanding: Bool) {
        guard let center = point else {
            return
        }

        self.circleView = self.circleView ??  UIView(frame: CGRect.init(x: 0, y: 0, width: 5, height: 5))
        
        circleView?.center =  center
        circleView?.layer.cornerRadius = (circleView?.bounds.width)!/2
        circleView?.backgroundColor = UIColor.red
        self.containerView.addSubview(circleView!)

        let p = self.view.bounds.width
        let b = self.view.bounds.height
        let rSquare = pow(p, 2) + pow(b, 2)
        let r = sqrt(rSquare)/6
        //
        
        
        let animator = UIViewPropertyAnimator(duration: 0.4, curve: UIViewAnimationCurve.easeInOut)
        
        if expanding {
            animator.addAnimations {
                self.circleView?.transform =  CGAffineTransform.init(scaleX: r, y: r)
            }
        }else {
            animator.addAnimations {
                self.circleView?.transform =  CGAffineTransform.identity
            }
        }
        
        
        animator.addCompletion { (_) in
//            self.backgroundLayer.backgroundColor = UIColor.red
//            self.circleView?.removeFromSuperview()
        }
        
        let blueColor = UIColor.init(red: 0, green: 169, blue: 209, alpha: 1)
        
        UIView.transition(with: self.headingTitlelabel, duration: 0.2, options: [UIViewAnimationOptions.transitionCrossDissolve, .curveEaseIn], animations: {
            self.headingTitlelabel.textColor =  expanding ? .white : blueColor
        }, completion: nil)
        
        animator.startAnimation()
    }
    
    

        func animate2(from point: CGPoint?, expanding: Bool) {
            guard let center = point else {
                return
            }
            
            self.circleView2 = self.circleView2 ??  UIView(frame: CGRect.init(x: 0, y: 0, width: 5, height: 5))
            circleView2?.center =  center
            circleView2?.layer.cornerRadius = (circleView2?.bounds.width)!/2
            circleView2?.backgroundColor = UIColor.red
            self.containerView2.addSubview(circleView2!)
            let p = self.view.bounds.width
            let b = self.view.bounds.height
            let rSquare = pow(p, 2) + pow(b, 2)
            let r = sqrt(rSquare)/6

            let animator = UIViewPropertyAnimator(duration: 0.4, curve: UIViewAnimationCurve.easeInOut)
            
            if expanding {
                animator.addAnimations {
                    self.circleView2?.transform =  CGAffineTransform.init(scaleX: r, y: r)
                }
            }else {
                animator.addAnimations {
                    self.circleView2?.transform =  CGAffineTransform.identity
                }
            }
            
            let blueColor = UIColor.init(red: 0, green: 169, blue: 209, alpha: 1)
            
            UIView.transition(with: self.headingTitleLabel2, duration: 0.2, options: [UIViewAnimationOptions.transitionCrossDissolve, .curveEaseIn], animations: {
                self.headingTitleLabel2.textColor =  expanding ? .white : blueColor
            }, completion: nil)
            
            animator.startAnimation()
            
            
        }
        
    
    
}

