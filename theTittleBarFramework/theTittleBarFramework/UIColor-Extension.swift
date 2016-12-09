//
//  UIColor-Extension.swift
//  theTittleBarFramework
//
//  Created by 甲丁乙_ on 2016/12/6.
//  Copyright © 2016年 甲丁乙_. All rights reserved.
//

import UIKit

extension UIColor{
  
    //MARK:扩充便利构造函数
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat,_ alpha:CGFloat = 1.0){
        self.init(red:r/255.0,green:g/255.0,blue:b/255.0,alpha:alpha)
    }
    
    //MARK:随机颜色方法
    //arc4random_uniform
    //arc4random使用了arc4密码加密的key stream生成器(请脑补)，产生一个[0, 2^32)区间的随机数(注意是左闭右开区间)。这个函数的返回类型是UInt32
    //arc4random_uniform，它接受一个UInt32类型的参数，指定随机数区间的上边界upper_bound，该函数生成的随机数范围是[0, upper_bound)
    class func randomColor() -> UIColor{
        return UIColor(r:CGFloat(arc4random_uniform(256)),g:CGFloat(arc4random_uniform(256)),b:(CGFloat(arc4random_uniform(256))))
    }
    
    //MARK:获取两个颜色的差值
    class func getColorsDifValue(firstColor:UIColor,secondColor:UIColor) -> (CGFloat,CGFloat,CGFloat){
        let firstRGB = UIColor.getRGBColor(firstColor)
        let secondRGB = UIColor.getRGBColor(secondColor)
        return (firstRGB.0-secondRGB.0,firstRGB.1-secondRGB.1,firstRGB.2-secondRGB.2)
    }
    
    //MARK:获取传入颜色的 RGB 值
    class func getRGBColor(_ color:UIColor) -> (CGFloat,CGFloat,CGFloat){
        guard let com = color.cgColor.components else {
            fatalError("保证传入的普通颜色为 RGB 形式")
        }
        return (com[0]*255,com[1]*255,com[2]*255)
    }
}
