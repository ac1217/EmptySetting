//
//  ViewController.swift
//  EmptySettingDemo
//
//  Created by zhangweiwei on 2017/5/14.
//  Copyright © 2017年 erica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.emptySetting.dataSource = self
        
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ID")
        
    }
    @IBAction func btnClick() {
        
        
        itemCount = (itemCount == 0) ? 10 : 0
        
        tableView.reloadData()
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        view.isShowingEmptySetting ? view.hideEmptySetting() : view.showEmptySetting()
        
        
    }
    
    var sectionCount = 1
    
    var itemCount = 0


}

extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID")!
        cell.textLabel?.text = "水电费是否\(indexPath.row)"
        return cell
    }
    
    
}

extension ViewController: EmptySettingDataSource {
    
    var emptySettingTitle: String? { return "12313" }
    var emptySettingDesc: String? { return "的是否是否" }
    var emptySettingImage: UIImage? { return UIImage(named: "Lover") }
    
    var emptySettingButtonNormalTitle: String? { return "我是按钮" }
    
    
}
