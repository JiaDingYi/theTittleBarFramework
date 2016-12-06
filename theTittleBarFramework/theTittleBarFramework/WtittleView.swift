//
//  WtittleView.swift
//  theTittleBarFramework
//
//  Created by 甲丁乙_ on 2016/12/5.
//  Copyright © 2016年 甲丁乙_. All rights reserved.
//

import UIKit

class WtittleView: UIView {
    //MARK:定义属性
    fileprivate var tittles : [String]!
    fileprivate var style : WtittleStyle!
    fileprivate var currentIndex : Int = 0
    fileprivate lazy var tittleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
       let scrollV = UIScrollView()
        scrollV.frame = self.bounds
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.scrollsToTop = false
        return scrollV
    }()
    //底部边界线
    fileprivate lazy var splitLineView : UIView = {
        let splitLine = UIView()
        splitLine.backgroundColor = UIColor.lightGray
        let h : CGFloat = 0.5
        splitLine.frame = CGRect(x:0,y:self.frame.height-h,width:self.frame.width,height:h)
        return splitLine
    }()
    //底部滚动条
    fileprivate lazy var bottomLine : UIView = {
       let bottomLine = UIView()
        bottomLine.backgroundColor = self.style.bottomLineColor
        return bottomLine
    }()
    //遮盖
    fileprivate lazy var coverView : UIView = {
        let coverView : UIView = UIView()
        coverView.backgroundColor = self.style.coverBgColor
        return coverView
    }()

    //MARK:自定义构造函数
     init(frame:CGRect,tittles:[String],style:WtittleStyle) {
        super.init(frame:frame)
        self.tittles = tittles
        self.style = style
        
        self.setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK:设置界面
extension WtittleView{
    fileprivate func  setUpUI (){
        self.backgroundColor = self.style.tittleBackgroundColor
        
        self.addSubview(self.scrollView)
        //添加底部分割线
        self.addSubview(self.splitLineView)
        
        if self.style.isShowBottomLine {
            
        }
        
        
    }
    
    //MARK:创建 tittleLabel
    fileprivate func createTittleLabel(){
        for (index,tittle) in tittles.enumerated() {
            let label : UILabel = UILabel()
            label.tag = index
            label.text = tittle
            label.textColor = index == 0 ? self.style.selectedColor : self.style.normalColor
            
        }
    }
}
