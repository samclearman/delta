//
//  CompassView.swift
//  delta
//
//  Created by Sam Clearman on 11/26/15.
//  Copyright © 2015 Sam Clearman. All rights reserved.
//

import Foundation
import UIKit

class CompassView: UIView {
    var heading = 0.0
    var course = 0.0
    
    override func drawRect(rect: CGRect) {
        let tau = 2.0 * M_PI
        
        let arrowLength = CGFloat(50.0)
        let arrowWidth = CGFloat((1.0/20.0) * tau)
        
        let hangle = -self.heading
        
        let cr = (rect.width / 2.0) - (arrowLength * 0.66)
        let crect = rect.insetBy(dx: arrowLength * 0.66, dy: arrowLength * 0.66)
        let circle = UIBezierPath(ovalInRect: crect)
        circle.lineWidth = 2
        circle.stroke()
        
        let context = UIGraphicsGetCurrentContext()
        let centerT = CGAffineTransformMakeTranslation(rect.width / 2.0, rect.height / 2.0)
        CGContextConcatCTM(context, centerT)
        CGContextConcatCTM(context, CGAffineTransformMakeRotation(CGFloat((hangle / 360) * tau)))
        
        let font = UIFont(name: "Helvetica Neue", size: 14.0)
        let attrs =  [NSFontAttributeName:font!] as [String: AnyObject]
        let hipt = CGPoint(x: -5.0, y: -cr - 18)
        
        let N:NSString = "N"
        N.drawAtPoint(hipt, withAttributes: attrs)
        CGContextConcatCTM(context, CGAffineTransformMakeRotation(CGFloat(0.25 * tau)))
        
        let E:NSString = "E"
        E.drawAtPoint(hipt, withAttributes: attrs)
        CGContextConcatCTM(context, CGAffineTransformMakeRotation(CGFloat(0.25 * tau)))
        
        let S:NSString = "S"
        S.drawAtPoint(hipt, withAttributes: attrs)
        CGContextConcatCTM(context, CGAffineTransformMakeRotation(CGFloat(0.25 * tau)))
        
        let W:NSString = "W"
        W.drawAtPoint(hipt, withAttributes: attrs)
        CGContextConcatCTM(context, CGAffineTransformMakeRotation(CGFloat(0.25 * tau)))
        
        let pta = CGFloat((-0.25 * 2.0 * M_PI) + ((course / 360) * tau))
        let pt = CGAffineTransformMakeRotation(pta)
        let pointer = UIBezierPath()
        //pointer.moveToPoint(CGPoint(x: 0.0, y: 0.0))
        pointer.addArcWithCenter(CGPoint(x: 0, y: 0), radius: (rect.width / 2.0) - arrowLength, startAngle: -arrowWidth / 2.0, endAngle: arrowWidth / 2.0, clockwise: true)
        pointer.addLineToPoint(CGPoint(x: rect.width / 2.0,y: 0.0))
        pointer.closePath()
        pointer.applyTransform(pt)
        UIColor(red: 0.18823, green: 0.43137, blue: 1.0, alpha: 1.0).setFill()
        pointer.fill()
        
    }
    
}