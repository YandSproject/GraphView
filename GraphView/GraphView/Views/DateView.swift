//
//  DateView.swift
//  GraphView
//
//  Created by YUMIKO HARAGUCHI on 2016/10/22.
//  Copyright © 2016年 YUMIKO HARAGUCHI. All rights reserved.
//

import UIKit

class DateView: UIView {

    
    var labels : [Date: UILabel] = [:]
    
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
    
    func setup(texts : [Date: String], positions: [Date : CGFloat]) {
        for (d, value) in texts {
            let label : UILabel = self.createLabel(text: value)
            self.addSubview(label)
            labels[d] = label
        }
        self.setLabelPositions(positions: positions)
    }
    
    func setLabelPositions(positions : [Date : CGFloat]) {
        for (d, value) in positions {
            if let label : UILabel = labels[d] {
                var rect : CGRect = label.frame
                rect.origin.x = value - (rect.size.width / 2)
                rect.size.height = self.frame.height
                label.frame = rect
            }
            
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    

}


//MARK: - Private method
extension DateView {
    
    fileprivate func createLabel(text : String) -> UILabel {
        
        let label : UILabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 60.0, height: 25.0))
        label.font = UIFont(name: "HelveticaNeue", size: 11.0)
        label.textAlignment = NSTextAlignment.center
        label.text = text
        label.textColor = UIColor.gray
        label.sizeToFit()
        return label
    }
}
