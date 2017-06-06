//
//  EmptySettingProtocol.swift
//  EmptySettingDemo
//
//  Created by zhangweiwei on 2017/5/18.
//  Copyright © 2017年 erica. All rights reserved.
//

import UIKit

protocol EmptySettingDataSource: NSObjectProtocol {
    
    var emptySettingTitle: String? { get }
    var emptySettingImage: UIImage? { get }
    var emptySettingDesc: String? { get }
    var emptySettingAttributedTitle: NSAttributedString? { get }
    var emptySettingAttributedDesc: NSAttributedString? { get }
    
    var emptySettingButtonNormalAttributedTitle: NSAttributedString? { get }
    var emptySettingButtonNormalTitle: String? { get }
    var emptySettingButtonNormalImage: UIImage? { get }
    var emptySettingButtonNormalBackgroundImage: UIImage? { get }
    var emptySettingButtonHighlightedTitle: String? { get }
    var emptySettingButtonHighlightedAttributedTitle: NSAttributedString? { get }
    var emptySettingButtonHighlightedImage: UIImage? { get }
    var emptySettingButtonHighlightedBackgroundImage: UIImage? { get }
    
}

extension EmptySettingDataSource {
    
    var emptySettingTitle: String? { return nil }
    var emptySettingImage: UIImage? { return nil }
    var emptySettingDesc: String? { return nil }
    var emptySettingAttributedTitle: NSAttributedString? { return nil }
    var emptySettingAttributedDesc: NSAttributedString? { return nil }
    
    var emptySettingButtonNormalAttributedTitle: NSAttributedString? { return nil }
    var emptySettingButtonNormalTitle: String? { return nil }
    var emptySettingButtonNormalImage: UIImage? { return nil }
    var emptySettingButtonNormalBackgroundImage: UIImage? { return nil }
    var emptySettingButtonHighlightedTitle: String? { return nil }
    var emptySettingButtonHighlightedAttributedTitle: NSAttributedString? { return nil }
    var emptySettingButtonHighlightedImage: UIImage? { return nil }
    var emptySettingButtonHighlightedBackgroundImage: UIImage? { return nil }
}

protocol EmptySettingDelegate: NSObjectProtocol {
    
    func emptySettingDidClickButton(_ emptySetting: EmptySetting)
    
}

extension EmptySettingDelegate {
    
    
    func emptySettingDidClickButton(_ emptySetting: EmptySetting){}
}
