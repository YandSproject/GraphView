//
//  GraphManager.swift
//  GraphView
//
//  Created by YUMIKO HARAGUCHI on 2016/10/22.
//  Copyright © 2016年 YUMIKO HARAGUCHI. All rights reserved.
//

import UIKit



class GraphManager: NSObject {

    var dateNum : Int = 7
    var divisionNum : Int = 5

    let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
    
    override init() {
        super.init()
    }
    
    func fetchDailyData(firstDate: Date, completed: ((GraphItem?)->Void)) {
        
        var item : GraphItem = GraphItem()
        item.dates = self.createDate(firstDate: firstDate)
        item.dateStrings = self.createDateString(dates: item.dates)
        item.divisionNum = self.divisionNum
        item.values = self.takeSampleData(dates: item.dates)
        completed(item)
    }
    

}


//MARK: - 日付（横軸）データを取得
extension GraphManager {
    
    ///グラフに必要な日付を日数分取得
    fileprivate func createDate(firstDate: Date) -> [Date]{
        var list : [Date] = []
        (0..<dateNum).forEach { (i) in
            if let date : Date = calendar.date(byAdding: NSCalendar.Unit.day, value: i, to: firstDate) {
                list.append(date)
            }
        }
        return list
    }
    
    ///日付をグラフ表示用に加工
    fileprivate func createDateString(dates: [Date]) -> [Date: String]  {
        var list : [Date: String] = [:]
        dates.forEach { (d) in
            let dateStr : String = self.dateFormatter(d: d)
            list[d] = dateStr
        }
        
        return list
    }
    

    ///日付フォーマット
    fileprivate func dateFormatter(d: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: d)
    }
}

//MARK: グラフの値を取得
extension GraphManager {
    
    fileprivate func takeSampleData(dates : [Date]) -> [Date: Float] {
        let values : [Float] = [46.6, 46.0, 47.0, 46.8, 46.3, 45.8, 46.2]
        var list : [Date: Float] = [:]
        
        for(index, date) in dates.enumerated() {
            if index < values.count {
                list[date] = values[index]
            }
        }
        
        return list
    }
}




