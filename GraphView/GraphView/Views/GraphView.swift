//
//  GraphView.swift
//  GraphView
//
//  Created by YUMIKO HARAGUCHI on 2016/10/22.
//  Copyright © 2016年 YUMIKO HARAGUCHI. All rights reserved.
//

import UIKit

class GraphView: UIView {
 
    fileprivate var values : [Date : Float] = [:]
    fileprivate var xPositions : [Date : CGFloat] = [:]
    
    fileprivate let DOT_SIZE : CGFloat = 4.0
    fileprivate var isAnimation : Bool = true

    fileprivate var minValue : Float = 0
    fileprivate var maxValue : Float = 0
    
    fileprivate var points : [CGPoint] = []
    fileprivate var dots : [CALayer] = []
    
    fileprivate let lineLayer : CAShapeLayer = CAShapeLayer()


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        self.initialize()
        
    }
    
    func initialize() {
        
    }
    
    func setup(values:[Date : Float], xPositions : [Date : CGFloat], minValue: Float, maxValue: Float) {
        self.layoutIfNeeded()
        self.minValue = minValue
        self.maxValue = maxValue
        self.values = values
        self.xPositions = xPositions
        
        self.takePoints()
    }

    func drawLine() {
        self.layoutIfNeeded()
        
        let weightPath : UIBezierPath = self.lineBezierPath(self.points)
        self.createLineCALayer(lineLayer, path: weightPath, lineColor: UIColor.orange, dotArray: self.dots)
        if(isAnimation == true){
            self.addLineAnimation(self.points, targetLayer: lineLayer)
            self.caLayerAnimation(self.dots)
        }
    }

    
}


//MARK: - Private
extension GraphView: CAAnimationDelegate {
    
    fileprivate func takePoints() {
        let interval : CGFloat = CGFloat(self.maxValue) - CGFloat(self.minValue)
         let ratio : CGFloat = interval / self.frame.height

        self.values.keys.sorted().forEach { (d) in
            let xPoint : CGFloat = self.xPositions[d] ?? 0.0
            let value : Float = self.values[d] ?? 0.0
            let yPosition : CGFloat = CGFloat(self.maxValue - value) / ratio
            let p : CGPoint = CGPoint(x: xPoint - 30.0, y: yPosition)
            self.points.append(p)
            self.dots.append(self.lineDotLayerAtPoint(p, dotColor: UIColor.orange))
        }
    }
    
    
    fileprivate func lineBezierPath(_ points : [CGPoint]) -> UIBezierPath {
        let path : UIBezierPath = UIBezierPath()
        var count : Int = 0
        for point : CGPoint in points {
            if(count == 0){
                path.move(to: point)
            }
            path.addLine(to: point)
            count += 1
        }
        return path
    }
    
    fileprivate func createLineCALayer(_ targetLayer : CAShapeLayer, path : UIBezierPath, lineColor : UIColor, dotArray : [CALayer]) {
        targetLayer.frame = self.frame
        targetLayer.path = path.cgPath
        targetLayer.lineWidth = 2.0
        targetLayer.strokeColor = lineColor.cgColor
        targetLayer.fillColor = UIColor.clear.cgColor
        for dot : CALayer in dotArray {
            targetLayer.addSublayer(dot)
        }
        
        self.layer.addSublayer(targetLayer)
        
    }
    
    fileprivate func addLineAnimation(_ points : [CGPoint], targetLayer : CAShapeLayer) {
        let lineAnimation : CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        lineAnimation.duration = 0.1 * Double(points.count)
        lineAnimation.delegate = self
        lineAnimation.fromValue = 0.0
        lineAnimation.toValue = 1.0
        lineAnimation.fillMode = kCAFillModeForwards
        lineAnimation.isRemovedOnCompletion = false
        targetLayer.add(lineAnimation, forKey: "strokeEnd")
        
    }
    
    fileprivate func caLayerAnimation(_ array : [CALayer]){
        var index : Int = 0
        for dot : CALayer in array {
            let delay = (0.1 * Double(index)) * Double(NSEC_PER_SEC)
            let time  = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: time, execute: {
                CATransaction.begin()
                CATransaction.setAnimationDuration(0.5)
                dot.transform = CATransform3DMakeScale(1, 1, 1)
                CATransaction.commit()
            })
            index += 1
        }
        
    }
    
    fileprivate func lineDotLayerAtPoint(_ pt : CGPoint, dotColor : UIColor) -> CALayer {
        let layer : CALayer = CALayer()
        layer.frame = CGRect(x: pt.x-DOT_SIZE, y: pt.y-DOT_SIZE, width: DOT_SIZE*2, height: DOT_SIZE*2)
        layer.cornerRadius = DOT_SIZE
        layer.backgroundColor = dotColor.cgColor
        var scale : CGFloat = 1.0
        if(isAnimation == true){
            scale = 0.0
        }
        layer.transform = CATransform3DMakeScale(scale, scale, scale);
        return layer;
        
    }


}
