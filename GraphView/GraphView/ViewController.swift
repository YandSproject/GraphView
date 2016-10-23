//
//  ViewController.swift
//  GraphView
//
//  Created by YUMIKO HARAGUCHI on 2016/10/22.
//  Copyright © 2016年 YUMIKO HARAGUCHI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let manager : GraphManager = GraphManager()

    @IBOutlet weak var graphView: GraphBaseView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        graphView.viewDidLayout()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        graphView.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupViews() {
        manager.fetchDailyData(firstDate: Date()) { (item) in
            graphView.setup(graphItem: item)
        }
    }
    
    

}

