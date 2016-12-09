//
//  WtittleView.swift
//  theTittleBarFramework
//
//  Created by 甲丁乙_ on 2016/12/5.
//  Copyright © 2016年 甲丁乙_. All rights reserved.
//

import UIKit

protocol WtittleViewDelegate : class {
    func tittleView(_ tittleView : WtittleView,didSelectedIndex : Int)
}

class WtittleView: UIView {
    //MARK:定义属性
    weak var delegate : WtittleViewDelegate?
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
        //创建所有标题 label
        self.createTittleLabel()
        //设置所有标题 label 的 frame
        self.setUpLabelPosition()
        //设置底部滚动条
        if self.style.isShowBottomLine {
            self.setUpBottomLine()
        }
        //设置遮盖 View
        if  self.style.isShowCover {
            self.setUpCoverView()
        }
    }
    
    //MARK:创建 tittleLabel
    fileprivate func createTittleLabel(){
        for (index,tittle) in tittles.enumerated() {
            let label : UILabel = UILabel()
            label.tag = index
            label.text = tittle
            label.textColor = index == 0 ? self.style.selectedColor : self.style.normalColor
            label.font = self.style.tittleFont
            label.textAlignment = NSTextAlignment.center
            //添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target:self,action:#selector(clickTittleLabel(_:)))
            label.addGestureRecognizer(tapGes)
            
            self.tittleLabels.append(label)
            self.scrollView.addSubview(label)
        }
    }
    
    //MARK:设置 label position
    fileprivate func setUpLabelPosition(){
        var tittleX : CGFloat = 0.0
        let tittleY : CGFloat = 0.0
        var tittleW : CGFloat = 0.0
        let tittleH : CGFloat = self.frame.height
        let count = self.tittles.count
        
        for (index,label) in self.tittleLabels.enumerated() {
            if self.style.isScrollEnable {
                let rect = (label.text! as NSString).boundingRect(with: CGSize(width:CGFloat(MAXFLOAT),height:0.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : self.style.tittleFont], context: nil)
                tittleW = rect.width
                if index == 0 {
                    tittleX = self.style.tittleMargin * 0.5
                }else{
                    let preLabel : UILabel = self.tittleLabels[index-1]
                    tittleX = preLabel.frame.maxX + self.style.tittleMargin
                }
            }else{
                tittleW = self.frame.width / CGFloat(count)
                tittleX = tittleW * CGFloat(index)
            }
            label.frame = CGRect(x: tittleX, y: tittleY, width: tittleW, height: tittleH)
            if index == 0 {
                //放大
                let scale = style.isNeedScale ? style.scaleRange : 1.0
                label.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        if self.style.isScrollEnable {
            self.scrollView.contentSize = CGSize(width: self.tittleLabels.last!.frame.maxX + self.style.tittleMargin * 0.5, height: 0)
        }
    }
    
    fileprivate func setUpBottomLine(){
        self.scrollView.addSubview(self.bottomLine)
        self.bottomLine.frame = self.tittleLabels.first!.frame
        self.bottomLine.frame.size.height = self.style.bottomH
        self.bottomLine.frame.origin.y = self.bounds.height - self.style.bottomH
    }
    
    fileprivate func setUpCoverView(){
        self.scrollView.insertSubview(self.coverView, at: 0)
        let firstLabel = tittleLabels.first!
        var coverX = firstLabel.frame.origin.x
        let coverY = (self.bounds.height - self.style.coverH) * 0.5
        var coverW = firstLabel.frame.width
        let coverH = self.style.coverH
        if self.style.isScrollEnable {
            coverX -= self.style.coverMargin
            coverW += self.style.coverMargin * 2
        }
        coverView.frame = CGRect(x: coverX, y: coverY, width: coverW, height: coverH)
        coverView.layer.cornerRadius = self.style.coverRadius
        coverView.layer.masksToBounds = true
        
    }
}

extension WtittleView{
    //tittleLabel 点击手势
    @objc fileprivate func clickTittleLabel(_ tapGes:UITapGestureRecognizer){
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        if currentLabel.tag == currentIndex {
            return
        }
        let oldLabel = self.tittleLabels[currentIndex]
        
        currentLabel.textColor = self.style.selectedColor
        oldLabel.textColor = self.style.normalColor
        
        //保存最新的 tag 值
        currentIndex = currentLabel.tag
        //通知代理
        delegate?.tittleView(self, didSelectedIndex: currentIndex)
        //调整 bottomLine
        if self.style.isShowBottomLine {
            self.bottomLine.frame.origin.x = currentLabel.frame.origin.x
            self.bottomLine.frame.size.width = currentLabel.frame.size.width
        }
        //调整缩放比例
        if self.style.isNeedScale {
            currentLabel.transform = oldLabel.transform
            oldLabel.transform = CGAffineTransform.identity //重置还原
        }
        //调整遮盖位置
        if self.style.isShowCover {
            let coverW = style.isScrollEnable ? (currentLabel.frame.width + style.tittleMargin) : (currentLabel.frame.width - 2 * style.coverMargin)
            coverView.frame.size.width = coverW
            coverView.center = currentLabel.center
        }
        //调整至中心位置
        adjustPosition(currentLabel)
    }
    fileprivate func adjustPosition(_ newLabel : UILabel) {
        guard style.isScrollEnable else { return }
        var offsetX = newLabel.center.x - scrollView.bounds.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        let maxOffset = scrollView.contentSize.width - bounds.width
        if offsetX > maxOffset {
            offsetX = maxOffset
        }
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

extension WtittleView : WcontentViewDelegate {
    func contentView(_ contentView: WcontrntView, endScroll inIndex: Int) {
        // 1.取出两个Label
        let oldLabel = tittleLabels[currentIndex]
        let newLabel = tittleLabels[inIndex]
        
        // 2.改变文字的颜色
        oldLabel.textColor = style.normalColor
        newLabel.textColor = style.selectedColor
        
        // 3.记录最新的index
        currentIndex = inIndex
        
        // 4.判断是否可以滚动
        adjustPosition(newLabel)
    }
    
    func contentView(_ contentView: WcontrntView, targetIndex: Int, progress: CGFloat) {
        // 1.取出两个Label
        let oldLabel = tittleLabels[currentIndex]
        let newLabel = tittleLabels[targetIndex]
        
        // 2.渐变文字颜色
        let selectRGB = UIColor.getRGBColor(self.style.selectedColor)
        let normalRGB = UIColor.getRGBColor(self.style.normalColor)
        let deltaRGB = UIColor.getColorsDifValue(firstColor: self.style.selectedColor, secondColor: self.style.normalColor)
        oldLabel.textColor = UIColor(r: selectRGB.0 - deltaRGB.0 * progress, g: selectRGB.1 - deltaRGB.1 * progress, b: selectRGB.2 - deltaRGB.2 * progress)
        newLabel.textColor = UIColor(r: normalRGB.0 + deltaRGB.0 * progress, g: normalRGB.1 + deltaRGB.1 * progress, b: normalRGB.2 + deltaRGB.2 * progress)
        
        // 3.渐变BottomLine
        if style.isShowBottomLine {
            let deltaX = newLabel.frame.origin.x - oldLabel.frame.origin.x
            let deltaW = newLabel.frame.width - oldLabel.frame.width
            bottomLine.frame.origin.x = oldLabel.frame.origin.x + deltaX * progress
            bottomLine.frame.size.width = oldLabel.frame.width + deltaW * progress
        }
        
        // 4.调整缩放
        if style.isNeedScale {
            let deltaScale = style.scaleRange - 1.0
            oldLabel.transform = CGAffineTransform(scaleX: style.scaleRange - deltaScale * progress, y: style.scaleRange - deltaScale * progress)
            newLabel.transform = CGAffineTransform(scaleX: 1.0 + deltaScale * progress, y: 1.0 + deltaScale * progress)
        }
        
        // 5.调整coverView
        if style.isShowCover {
            let oldW = style.isScrollEnable ? (oldLabel.frame.width + style.tittleMargin) : (oldLabel.frame.width - 2 * style.coverMargin)
            let newW = style.isScrollEnable ? (newLabel.frame.width + style.tittleMargin) : (newLabel.frame.width - 2 * style.coverMargin)
            let deltaW = newW - oldW
            let deltaX = newLabel.center.x - oldLabel.center.x
            coverView.frame.size.width = oldW + deltaW * progress
            coverView.center.x = oldLabel.center.x + deltaX * progress
        }
    }    
}

    
