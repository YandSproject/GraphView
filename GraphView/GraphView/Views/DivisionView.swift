//
//  DivisionView.swift
//  GraphView
//
//  Created by YUMIKO HARAGUCHI on 2016/10/22.
//  Copyright © 2016年 YUMIKO HARAGUCHI. All rights reserved.
//

import UIKit

class DivisionView: UIView {

    var divisionNum : Int = 6
    var labels : [UILabel] = []
    var minValue: Float = 0.0
    var maxValue: Float = 0.0
    var perValue: Float = 0.0
    
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

    func setup(minValue: Float, maxValue: Float, perValue: Float) {
        self.layoutIfNeeded()
        
        self.minValue = minValue
        self.maxValue = maxValue
        self.perValue = perValue
        
        (0..<divisionNum - 1).forEach { (i) in
            let label : UILabel = createLabel(text: "test")
            self.addSubview(label)
            self.labels.append(label)
        }
        
        self.labelPosition()
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    

}


//MARK: - Private method
extension DivisionView {
    
    fileprivate func createLabel(text : String) -> UILabel {
        
        let label : UILabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 15.0))
        label.font = UIFont(name: "HelveticaNeue", size: 10.0)
        label.textAlignment = NSTextAlignment.center
        label.text = text
        label.textColor = UIColor.gray
        label.sizeToFit()
        return label
    }
    
    fileprivate func labelPosition() {
        self.layoutIfNeeded()
        let interval : CGFloat = CGFloat(self.maxValue) - CGFloat(self.minValue)
        
        let valueInterval : CGFloat = interval / CGFloat(divisionNum + 1)
        
        for (index, label) in labels.enumerated() {

            var rect : CGRect = label.frame
            rect.size.width = self.frame.width
            rect.origin.y = ((self.frame.height / 6.0) * CGFloat(index + 1))
            label.frame = rect
            
            let value =  CGFloat(self.maxValue) - (valueInterval * CGFloat(index + 1))
            label.text = "\(NSString(format: "%.1f", value))"

        }
        
        
    }
}



