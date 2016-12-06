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
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: 设置界面内容
extension WpageView{
    
}
