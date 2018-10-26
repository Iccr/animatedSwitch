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
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var backgroundLayer: UIView!
    let containerView = UIView()
    var circleView: UIView?
    let hightlightColor = UIColor.init(rgb: 0x89B73B)
    let siwtchOffStateColor = UIColor.lightGray
    let hightlightHeadingColor = UIColor.init(rgb: 0x10ABFE)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundLayer.clipsToBounds = true
        self.containerView.frame = self.backgroundLayer.frame
        self.backgroundLayer.insertSubview(containerView, at: 0)
        self.switch1.setOn(false, animated: false)
        self.switch1.onTintColor = UIColor.init(rgb: 0x739E66)
        self.switch1.tintColor = UIColor.lightGray
    }
    

    @IBAction func switch1(_ sender: UISwitch) {
        animate(from: self.switch1.center, expanding: sender.isOn)
    }
    

    
    func animate(from point: CGPoint?, expanding: Bool) {
        guard let center = point else {
            return
        }

        self.circleView = self.circleView ??  UIView(frame: CGRect.init(x: 0, y: 0, width: 5, height: 5))
        
        circleView?.center =  center
        circleView?.layer.cornerRadius = (circleView?.bounds.width)!/2
        circleView?.backgroundColor = hightlightColor
        self.containerView.addSubview(circleView!)

        let p = self.view.bounds.width
        let b = self.view.bounds.height
        let rSquare = pow(p, 2) + pow(b, 2)
        let r = sqrt(rSquare)/6
        
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
        
        let blueColor = hightlightHeadingColor
        UIView.transition(with: self.headingTitlelabel, duration: 0.2, options: [UIViewAnimationOptions.transitionCrossDissolve, .curveEaseIn], animations: {
            self.headingTitlelabel.textColor =  expanding ? .white : blueColor
        }, completion: nil)
        
        animator.startAnimation()
    }
}



extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
