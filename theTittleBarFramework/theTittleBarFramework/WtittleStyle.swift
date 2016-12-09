//
//  WtittleStyle.swift
//  theTittleBarFramework
//
//  Created by 甲丁乙_ on 2016/12/5.
//  Copyright © 2016年 甲丁乙_. All rights reserved.
//

import UIKit

class WtittleStyle {
    //标题栏是否可以滚动
    var isScrollEnable : Bool = true
    //普通 tittle 的颜色
    var normalColor : UIColor = UIColor(r:0,g:0,b:0)
    //选中 tittle 的颜色
    var selectedColor = UIColor(r:255,g:127,b:0)
    //tittle 字体大小
    var tittleFont : UIFont = UIFont.systemFont(ofSize: 14.0)
    //滚动 tittle 的字体间距
    var tittleMargin : CGFloat = 20.0
    //tittleView 的高度
    var tittleHeight : CGFloat = 44
    //tittleView 的背景颜色
    var tittleBackgroundColor : UIColor = .clear
    
    //是否显示 tittle 底部的滚动条
    var isShowBottomLine : Bool = true
    //底部滚动条的颜色
    var bottomLineColor : UIColor = UIColor(r:255,g:127,b:0)
    //底部滚动条的高度
    var bottomH : CGFloat = 2
    
    // 是否进行缩放
    var isNeedScale : Bool = false
    var scaleRange : CGFloat = 1.2
    
    // 是否显示遮盖
    var isShowCover : Bool = false
    // 遮盖背景颜色
    var coverBgColor : UIColor = UIColor.lightGray
    // 文字&遮盖间隙
    var coverMargin : CGFloat = 5
    // 遮盖的高度
    var coverH : CGFloat = 25
    // 遮盖的宽度
    var coverW : CGFloat = 0
    // 设置圆角大小
    var coverRadius : CGFloat = 12
    
}
