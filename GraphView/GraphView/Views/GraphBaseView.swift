//
//  GraphBaseView.swift
//  GraphView
//
//  Created by YUMIKO HARAGUCHI on 2016/10/22.
//  Copyright © 2016年 YUMIKO HARAGUCHI. All rights reserved.
//

import UIKit

struct GraphItem {
    var divisionNum : Int = 5
    var dates: [Date] = []
    var dateStrings: [Date : String] = [:]
    var values : [Date : Float] = [:]
}


class GraphBaseView: UIView {

    var item : GraphItem?
    
    var contentView : UIView?
    @IBOutlet weak var dateView: DateView!
    @IBOutlet weak var divisionView: DivisionView!
    @IBOutlet weak var graphView: GraphView!
    
    fileprivate var xPositions : [Date : CGFloat] = [:]
    fileprivate var valuePerYPoint : Float = 0.0
    fileprivate var minYValue : Float = 0.0
    fileprivate var maxYValue : Float = 0.0
    
    

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
        if let view : UIView = Bundle.main.loadNibNamed("GraphBaseView", owner: self, options: nil)?.first as? UIView {
            contentView = view
            self.addSubview(contentView!)
            contentView?.frame = self.frame
        }
    }
        

    func setup(graphItem: GraphItem?) {
        self.item = graphItem
        self.setPositions()
        
        if let dateStrs: [Date : String] = item?.dateStrings {
            self.dateView.setup(texts: dateStrs, positions: self.xPositions)
        }
        self.divisionView.setup(minValue: minYValue, maxValue: maxYValue, perValue: valuePerYPoint)
        
        self.graphView.setup(values: self.item!.values, xPositions: self.xPositions, minValue: minYValue, maxValue: maxYValue)
    }
    
    func show() {
        self.graphView.drawLine()

    }
    func viewDidLayout() {
    }
    
    func setPositions() {
        if let d : [Date] = self.item?.dates {
            self.xPositions = self.createXPositions(dates: d)
        }
        if let values : [Date: Float] = item?.values {
            self.createYPosition(values: values)
        }
        
    }

}


//MARK: - private method
extension GraphBaseView {
    
    ///日付の表示位置（X）
    fileprivate func createXPositions(dates: [Date]) -> [Date : CGFloat]{
        
        dateView.layoutIfNeeded()
        let margin : CGFloat = 20.0
        let interval : CGFloat = (dateView.frame.size.width - (margin * 2)) / CGFloat((item?.dates.count ?? 0) - 1)
        let startPosition : CGFloat = margin
        var datePointX : [Date : CGFloat] = [:]
        
        for (index, d) in dates.enumerated() {
            let position : CGFloat = startPosition + (interval * CGFloat(index))
            datePointX[d] = position
        }
        return datePointX
    }
    
    ///Yの位置を決定するために必要な値を出す。
    fileprivate func createYPosition(values : [Date: Float]) {
        divisionView.layoutIfNeeded()
        
        let list = values.map {$1}
        let margin : Float = 1.0
        minYValue = (list.min() ?? 0) - margin
        maxYValue = (list.max() ?? 0) + margin
        
        let interval : Float = maxYValue - minYValue
        valuePerYPoint = interval / Float(divisionView.frame.height)
        
    }

}










