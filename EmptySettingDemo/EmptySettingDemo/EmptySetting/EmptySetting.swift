//
//  EmptySettingView.swift
//  PMEC-Metal
//
//  Created by zhangweiwei on 2017/1/11.
//  Copyright © 2017年 pmec. All rights reserved.
//

import UIKit

// MARK: - Public Method
extension EmptySetting {
    
    var isShowing: Bool {
        return alpha == 1
    }
    
    func show(_ animated: Bool = true) {
        
        reloadData()
        
        setNeedsLayout()
        
        if isShowing { return }
        
        if animated {
            
           UIView.animate(withDuration: 0.25, animations: { 
                self.alpha = 1;
           })
            
        }else {
            
            alpha = 1;
        }
        
    }
    
    
    func hide(_ animated: Bool = true) {
        
        if !isShowing { return }
        
        if animated {
            
            UIView.animate(withDuration: 0.25, animations: {
                self.alpha = 0;
            })
        }else {
            
            alpha = 0;
        }
    }
    
    
    
}

class EmptySetting: UIView {
    
    var autoDisplayInScrollView = true
    
    var appearance: EmptySettingAppearance = EmptySettingAppearance()
    
    weak var delegate: EmptySettingDelegate?
    weak var dataSource: EmptySettingDataSource?
    
    var margin: CGFloat = 10
    
    var btnClosure: ((EmptySetting)->())?

    lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(EmptySetting.btnClick), for: .touchUpInside)
      
        return btn
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var descLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maxSize = CGSize(width: UIScreen.main.bounds.width * 0.75, height: 0)
        
        let imageSize = imageView.sizeThatFits(maxSize)
        
        let descSize = descLabel.sizeThatFits(maxSize)
        
        let titleSize = titleLabel.sizeThatFits(maxSize)
        
        
        var buttonSize = CGSize.zero
        if button.currentTitle != nil || button.currentAttributedTitle != nil || button.currentImage != nil || button.currentBackgroundImage != nil {
            buttonSize = button.sizeThatFits(maxSize)
        }
        
        var height: CGFloat = margin
        
        imageView.frame.origin.y = height
        if imageSize != CGSize.zero {
            height += imageSize.height
            height += margin
        }
        
        titleLabel.frame.origin.y = height
        if titleSize != CGSize.zero {
            height += titleSize.height
            height += margin
        }
        
        descLabel.frame.origin.y = height
        if descSize != CGSize.zero {
            height += descSize.height
            height += margin
        }
        
        button.frame.origin.y = height
        if buttonSize != CGSize.zero {
            buttonSize.width += 2 * margin
            buttonSize.height += margin
            height += buttonSize.height
            height += margin
        }
        
        imageView.frame.size = imageSize
        descLabel.frame.size = descSize
        titleLabel.frame.size = titleSize
        button.frame.size = buttonSize
        
        frame.size.height = height
        frame.size.width = max(imageSize.width, titleSize.width, descSize.width, buttonSize.width) + 2 * margin
        
        imageView.center.x = frame.width * 0.5
        
        titleLabel.center.x = imageView.center.x
        
        descLabel.center.x = titleLabel.center.x
        
        button.center.x = descLabel.center.x
        
        guard let superview = superview else {
            return
        }
        
        center = CGPoint(x: superview.bounds.width * 0.5, y: superview.bounds.height * 0.5)
        
    }
    
    
}

// MARK: - Event
extension EmptySetting {
    
    func btnClick() {
        btnClosure?(self)
        delegate?.emptySettingDidClickButton(self)
    }
}

// MARK: - Private Method
extension EmptySetting {
    
    func setupUI() {
        alpha = 0
        addSubview(imageView)
        addSubview(button)
        addSubview(titleLabel)
        addSubview(descLabel)
    }
    
    func reloadData() {
        
        if dataSource?.responds(to: Selector("emptySettingTitle")) ?? false {
            
            titleLabel.textColor = appearance.titleColor
            titleLabel.font = appearance.titleFont
            titleLabel.text = dataSource?.emptySettingTitle
        }
        
        if dataSource?.responds(to: Selector("emptySettingAttributedTitle")) ?? false {
            
            titleLabel.attributedText = dataSource?.emptySettingAttributedTitle
        }
        
        if dataSource?.responds(to: Selector("emptySettingImage")) ?? false {
            
            imageView.image = dataSource?.emptySettingImage
        }
        
        if dataSource?.responds(to: Selector("emptySettingDesc")) ?? false {
            
            descLabel.textColor = appearance.descColor
            descLabel.font = appearance.descFont
            descLabel.text = dataSource?.emptySettingDesc
        }
        
        if dataSource?.responds(to: Selector("emptySettingAttributedDesc")) ?? false {
            
            descLabel.attributedText = dataSource?.emptySettingAttributedDesc
        }
        
        
        if dataSource?.responds(to: Selector("emptySettingButtonNormalTitle")) ?? false {
            
            button.setTitleColor(appearance.buttonNormalColor, for: .normal)
            button.setTitle(dataSource?.emptySettingButtonNormalTitle, for: .normal)
        }
        
        if dataSource?.responds(to: Selector("emptySettingButtonNormalAttributedTitle")) ?? false {
            
            
            button.setAttributedTitle(dataSource?.emptySettingButtonNormalAttributedTitle, for: .normal)
        }
        
        
        if dataSource?.responds(to: Selector("emptySettingButtonHighlightedTitle")) ?? false {
            
            button.setTitleColor(appearance.buttonHighlightedColor, for: .highlighted)
            button.setTitle(dataSource?.emptySettingButtonHighlightedTitle, for: .highlighted)
        }
        
        if dataSource?.responds(to: Selector("emptySettingButtonHighlightedAttributedTitle")) ?? false {
            
            button.setAttributedTitle(dataSource?.emptySettingButtonHighlightedAttributedTitle, for: .highlighted)
        }
        
        if dataSource?.responds(to: Selector("emptySettingButtonNormalImage")) ?? false {
            
            button.setImage(dataSource?.emptySettingButtonNormalImage, for: .normal)
            
        }
        
        if dataSource?.responds(to: Selector("emptySettingButtonHighlightedImage")) ?? false {
            
            button.setImage(dataSource?.emptySettingButtonHighlightedImage, for: .highlighted)
        }
        
        if dataSource?.responds(to: Selector("emptySettingButtonNormalBackgroundImage")) ?? false {
            
            button.setImage(dataSource?.emptySettingButtonNormalBackgroundImage, for: .normal)
            
        }
        
        if dataSource?.responds(to: Selector("emptySettingButtonHighlightedBackgroundImage")) ?? false {
            
            button.setImage(dataSource?.emptySettingButtonHighlightedBackgroundImage, for: .highlighted)
        }
        
    }
    
}
