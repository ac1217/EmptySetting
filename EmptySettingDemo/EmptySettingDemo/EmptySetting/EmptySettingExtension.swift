//
//  EmptySettingExtension.swift
//  EmptySettingDemo
//
//  Created by zhangweiwei on 2017/5/18.
//  Copyright © 2017年 erica. All rights reserved.
//

import UIKit
import ObjectiveC.runtime

extension UIView {
    
    var emptySettingDataSource: EmptySettingDataSource? {
        
        set {
            emptySetting.dataSource = newValue
        }
        
        get {
            return emptySetting.dataSource
        }
        
    }
    
    var emptySettingDelegate: EmptySettingDelegate? {
        
        set {
            emptySetting.delegate = newValue
        }
        
        get {
            return emptySetting.delegate
        }
        
    }
    
    var isShowingEmptySetting: Bool {
        return emptySetting.isShowing
    }
    
    func showEmptySetting(_ animated: Bool = true) {
        
        emptySetting.show(animated)
        
    }
    
    
    func hideEmptySetting(_ animated: Bool = true) {
        
        emptySetting.hide(animated)
    }
    
    
    var emptySetting: EmptySetting {
        
        var emptySetting: EmptySetting!
        
        for subview in subviews {
            if let subview = subview as? EmptySetting {
                emptySetting = subview
                break
            }
        }
        
        if emptySetting == nil {
            emptySetting = EmptySetting()
            addSubview(emptySetting)
            
            swizzleMethod()
        }
        
        bringSubview(toFront: emptySetting)
        
        return emptySetting;
        
    }
    
    var autoDisplayEmptySettingInScrollView: Bool {
        set {
            emptySetting.autoDisplayInScrollView = newValue
        }
        get {
            return emptySetting.autoDisplayInScrollView
        }
    }
    
    func swizzleMethod() {
        
        if let tableView = self as? UITableView {
            
            
            let reloadData1 = class_getInstanceMethod(type(of: tableView), "reloadData")
            let reloadData2 = class_getInstanceMethod(type(of: tableView), "es_reloadData")
            
            
            
            method_exchangeImplementations(reloadData1, reloadData2)
            
            
            let endUpdates1 = class_getInstanceMethod(type(of: tableView), "endUpdates")
            let endUpdates2 = class_getInstanceMethod(type(of: tableView), "es_endUpdates")
            method_exchangeImplementations(endUpdates1, endUpdates2)
            
        }else if let collectionView = self as? UICollectionView {
            
            
            let reloadData1 = class_getInstanceMethod(type(of: collectionView), "reloadData")
            let reloadData2 = class_getInstanceMethod(type(of: collectionView), "es_reloadData")
            
            method_exchangeImplementations(reloadData1, reloadData2)
            
        }
        
    }
    
    func es_endUpdates() {
        
        es_endUpdates()
        
        if !autoDisplayEmptySettingInScrollView {
            return
        }
        
        itemCount == 0 ? showEmptySetting() : hideEmptySetting()
        
    }
    
    func es_reloadData() {
        es_reloadData()
        
        if !autoDisplayEmptySettingInScrollView {
            return
        }
        itemCount == 0 ? showEmptySetting() : hideEmptySetting()
        
    }
    
    var itemCount: Int {
        
        var itemCount = 0
        if let tableView = self as? UITableView {
            
            let dataSource = tableView.dataSource
            
            let sections = dataSource?.numberOfSections?(in: tableView) ?? 1
            
            
            for section in 0..<sections {
                
                itemCount += dataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
            }
            
            
        }else if let collectionView = self as? UICollectionView {
            
            
            let dataSource = collectionView.dataSource
            
            let sections = dataSource?.numberOfSections?(in: collectionView) ?? 1
            
            
            for section in 0..<sections {
                
                itemCount += dataSource?.collectionView(collectionView, numberOfItemsInSection: section) ?? 0
            }
            
        }
        return itemCount
    }
    
}
