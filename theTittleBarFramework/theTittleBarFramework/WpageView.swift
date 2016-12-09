//
//  WpageView.swift
//  theTittleBarFramework
//
//  Created by 甲丁乙_ on 2016/12/5.
//  Copyright © 2016年 甲丁乙_. All rights reserved.
//

import UIKit

class WpageView : UIView {
    
    //MARK:定义属性
    fileprivate var tittles : [String] = [String]()
    fileprivate var style : WtittleStyle = WtittleStyle()
    fileprivate var childVcs : [UIViewController] = [UIViewController]()
    fileprivate var parentVc = UIViewController()
    

    //MARK:自定义构造函数
    /*
     @ param frame      尺寸
     @ param tittles      标题数组
     @ param style        样式
     @ param childVcs   自控制器数组
     @ param parentVc  父控制器
     */
    init(frame:CGRect,tittles:[String],style:WtittleStyle,childVcs:[UIViewController],parentVc:UIViewController) {
        super.init(frame:frame)
        self.tittles = tittles
        self.style = style
        self.childVcs = childVcs
        self.parentVc = parentVc
        guard self.tittles.count == self.childVcs.count else {
            fatalError("标题数组的数量必须与自控制器数组的数量一致")
        }
        self.setupUI()
}
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: 设置界面内容
extension WpageView{
    fileprivate func setupUI() {
        // 1.添加titleView到pageView中
        let titleViewFrame = CGRect(x: 0, y: 0, width: bounds.width, height: self.style.tittleHeight)
        let titleView = WtittleView(frame: titleViewFrame, tittles: self.tittles, style : self.style)
        addSubview(titleView)
        titleView.backgroundColor = UIColor.randomColor()
        
//         2.添加contentView到pageView中
        let contentViewFrame = CGRect(x: 0, y: titleView.frame.maxY, width: bounds.width, height: frame.height - titleViewFrame.height)
        let contentView = WcontrntView(frame: contentViewFrame, childVcs: childVcs, parentVc: parentVc)
        addSubview(contentView)
        contentView.backgroundColor = UIColor.randomColor()
        
        // 3.设置contentView&titleView关系
        titleView.delegate = contentView
        contentView.delegate = titleView
    }

}
