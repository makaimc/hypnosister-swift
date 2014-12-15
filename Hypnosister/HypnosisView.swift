//
//  HypnosisView.swift
//  Hypnosister
//
//  Created by Matthew Makai on 12/15/14.
//  Copyright (c) 2014 Twilio. All rights reserved.
//

import UIKit

class HypnosisView: UIView {

    var radiusOffset: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var timer: NSTimer?
    
    override func didMoveToSuperview() {
        if superview != nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0/30.0, target: self, selector: "timerFired:", userInfo: nil, repeats: true)
        }
    }
    
    override func removeFromSuperview() {
        timer?.invalidate()
        timer = nil
        
        super.removeFromSuperview()
    }
    
    func timerFired(timer: NSTimer) {
        println("pew")
        
        radiusOffset += 1.0
        
        if radiusOffset > 20 {
            radiusOffset = 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let bounds = self.bounds
        
        let logoImage: UIImage? = UIImage(named: "fsp-trans-logo.png")
        logoImage?.drawInRect(rect)
        
        let centerX = bounds.origin.x + bounds.size.width / 2.0
        let centerY = bounds.origin.y + bounds.size.height / 2.0
        let center = CGPoint(x: centerX, y: centerY)
        
        let maxRadius = CGFloat(hypot(CDouble(bounds.size.width), CDouble(bounds.size.height)) / 2.0)
        
        for var radius: CGFloat = 0.0; radius < maxRadius; radius += 20 {
            let path = UIBezierPath()
            
            path.addArcWithCenter(center,
                radius: radius,
                startAngle: 0,
                endAngle: CGFloat(M_PI * 2.0),
                clockwise: true)
            
            path.lineWidth = 10
            
            let alpha = ((radius + radiusOffset - 10) / maxRadius)
            UIColor.whiteColor().colorWithAlphaComponent(alpha).setStroke()

            
            path.stroke()
        }
    }

}
