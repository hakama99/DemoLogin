//
//  UIViewDashBorder.swift
//  OpusOrbis
//
//  Created by 林鏡銓 on 2020/1/10.
//  Copyright © 2020 Mark. All rights reserved.
//

import UIKit

public let kShapeDashed : String = "kShapeDashed"

extension UIView {
    
    func removeShapBorder() {
        self.layer.sublayers?.forEach {
            if kShapeDashed == $0.name {
                $0.removeFromSuperlayer()
            }
        }
        self.layer.mask = nil
    }

    func addDashedBorder(width: CGFloat? = nil, height: CGFloat? = nil, lineWidth: CGFloat = 2, lineDashPattern:[NSNumber]? = [6,3], strokeColor: UIColor = UIColor.red, fillColor: UIColor = UIColor.clear, masksToBounds: Bool? = nil, cornerRadius: CGFloat = 5) {
        
        var fWidth: CGFloat? = width
        var fHeight: CGFloat? = height
        
        if fWidth == nil {
            fWidth = self.frame.width
        }
        
        if fHeight == nil {
            fHeight = self.frame.height
        }
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()

        let shapeRect = CGRect(x: 0, y: 0, width: fWidth!, height: fHeight!)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: fWidth!/2, y: fHeight!/2)
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = lineDashPattern
        shapeLayer.name = kShapeDashed
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath
        
        if masksToBounds != nil{
            layer.masksToBounds = masksToBounds!
        }
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func addCustomBorder(width: CGFloat? = nil, height: CGFloat? = nil,lineWidth: CGFloat = 2, strokeColor: UIColor = UIColor.red, fillColor: UIColor = UIColor.clear, masksToBounds: Bool? = nil, cornerRadius: CGFloat = 5, byRoundingCorners: UIRectCorner = [.topLeft, .bottomLeft]) {
        
        var fWidth: CGFloat? = width
        var fHeight: CGFloat? = height
        
        if fWidth == nil {
            fWidth = self.frame.width
        }
        
        if fHeight == nil {
            fHeight = self.frame.height
        }
        let shapeRect = CGRect(x: 0, y: 0, width: fWidth!, height: fHeight!)
         
        let maskPath = UIBezierPath(roundedRect: shapeRect, byRoundingCorners: byRoundingCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = shapeRect
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer

        
        let borderLayer = CAShapeLayer()
        borderLayer.frame = shapeRect
        borderLayer.path = maskPath.cgPath
        borderLayer.lineWidth = lineWidth
        borderLayer.fillColor = fillColor.cgColor
        borderLayer.strokeColor = strokeColor.cgColor
        borderLayer.name = kShapeDashed
        
        if masksToBounds != nil{
            layer.masksToBounds = masksToBounds!
        }
        self.layer.addSublayer(borderLayer)        
    }
}
